//
//  LoadableVCExtension.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 1/30/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import UIKit
extension LoadableVC where Self: UIViewController {
    
    
    func handleTransportation(data: String) {
        
       
        
        let sb = UIStoryboard(name: "Main", bundle: nil)

        //End of exam
        if currentExam == nil {
            let main = sb.instantiateInitialViewController()
            
            if let loadableVC = main as? LoadableVC {
                present(vc: loadableVC)
            }
            return
        }
        //Loop hole need to fix...User can the name of a button that calls a trigger it will call it
        
        let instance = OneInstance.shared
        
        if let trigger = instance.trigger {
            //Is triggered
            ResumeDataHandler.shared.updateData(for: trigger, exam: currentExam, data: data)
            
            if let nextExam = trigger.next(exam: currentExam) {
                //trigger has next exam
                
                handleSegues(currentExamKind: currentExam.kind(), nextExam: nextExam)
            } else {
                //End of trigger
                let beforeExam = instance.examBeforeTrigger
                instance.trigger = nil
                
                if ResumeDataHandler.shared.editingResume {
                    ResumeDataHandler.shared.updateData(for: trigger, exam: currentExam, data: data)
                    ResumeDataHandler.shared.putEmploymentAndEducationInResume()
                    PersistantService.saveContext()
                    dismiss(animated: true, completion: nil)
                    return
                }
                
                if let nextExam = beforeExam.next() {
                    let kind = currentExam.kind()
                    currentExam = beforeExam
                    handleSegues(currentExamKind: kind, nextExam: nextExam)
                }
                ResumeDataHandler.shared.putEmploymentAndEducationInResume()
            }
            
            
        } else {
            //Not triggered
            if let trigger = Trigger(rawValue: data) {
                //If the data is a a trigger
                instance.trigger = trigger
                instance.examBeforeTrigger = currentExam
                //First Exam of Trigger
                //Create a new Model for the Trigger
                ResumeDataHandler.shared.updateData(for: trigger, exam: currentExam, data: data)
            
                
                //Get the exam for the first trigger
                if let triggerExam = trigger.next(exam: nil) {
                    handleSegues(currentExamKind: currentExam.kind(), nextExam: triggerExam)
                } else {
                    print("Data is a trigger, trigger does not any exams :(")
                }
            } else {
                //Normal segue
                if ResumeDataHandler.shared.editingResume {
                    //Editing data from EditResumeVC
                    ResumeDataHandler.shared.updateData(dataType: currentExam, data: data)
                    PersistantService.saveContext()
                    dismiss(animated: true, completion: nil)
                    return
                }
                
                
                if let nextExam = currentExam.next() {
                    if currentExam != .menu {
                        ResumeDataHandler.shared.updateData(dataType: currentExam, data: data)
                    }
                    handleSegues(currentExamKind: currentExam.kind(), nextExam: nextExam)
                } else {
                    //End of Exams
                    let vc = sb.instantiateViewController(withIdentifier: "EXAM_ENDED") as! ExamEndedVC
                    vc.gender = ResumeDataHandler.shared.gender()
                    ResumeDataHandler.shared.updateData(dataType: currentExam, data: data)
                    PersistantService.saveContext()
                    present(vc: vc)
                    return
                }
            }
        }
        
    }
    
    private func handleSegues(currentExamKind: Exam.Kind, nextExam: Exam) {
        let nextKind = nextExam.kind()
        if nextKind == currentExamKind {
            //Stay and update current view
            self.currentExam = nextExam
            self.updateData()
        } else {
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: nextKind.rawValue)
            if let loadableVC = vc as? LoadableVC {
                loadableVC.currentExam = nextExam
                present(vc: loadableVC)
                
            }
            
        }
    }
    
    private func present(vc: LoadableVC) {
            vc.presenting = self
            present(vc as! UIViewController, animated: true, completion: {
                self.removeSubViews()
            })
            vc.updateData()
        
    }
    
    private func removeSubViews() {
        for v in view.subviews{
            v.removeFromSuperview()
        }
    }

}
