import Foundation
import XCTest

/*
 There are a total of numCourses courses you have to take, labeled from 0 to numCourses - 1. You are given an array prerequisites where prerequisites[i] = [ai, bi] indicates that you must take course bi first if you want to take course ai.

     For example, the pair [0, 1], indicates that to take course 0 you have to first take course 1.

 Return true if you can finish all courses. Otherwise, return false.

 Example 1:

 Input: numCourses = 2, prerequisites = [[1,0]]
 Output: true
 Explanation: There are a total of 2 courses to take.
 To take course 1 you should have finished course 0. So it is possible.

 Example 2:

 Input: numCourses = 2, prerequisites = [[1,0],[0,1]]
 Output: false
 Explanation: There are a total of 2 courses to take.
 To take course 1 you should have finished course 0, and to take course 0 you should also have finished course 1. So it is impossible.
 Constraints:

     1 <= numCourses <= 2000
     0 <= prerequisites.length <= 5000
     prerequisites[i].length == 2
     0 <= ai, bi < numCourses
     All the pairs prerequisites[i] are unique.

 */

class Course {
    let name: Int
    let prerequisite: Course?
    
    
    init(name: Int, prerequisite: Course) {
        self.name = name
        self.prerequisite = prerequisite
    }
}


class Solution {
    func canFinish(_ numCourses: Int, _ prerequisites: [[Int]]) -> Bool {
        var preReqRequired = [Int](repeating: 0, count: numCourses)
        var dependentCourses = [Int: [Int]]()
        guard numCourses > 0 else { return true }
        
        prerequisites.forEach { pair in
            let course = pair[0] //ai
            let prereq = pair[1] //bi
            
            preReqRequired[course] += 1
            dependentCourses[prereq, default: []].append(course)
        }
        
        var totalCourseYouCanTake = 0
//        print("preReqRequired: \(preReqRequired)")
        var canTakeCourses = preReqRequired.enumerated().compactMap { $0.element == 0 ? $0.offset : nil }
        while !canTakeCourses.isEmpty {
            totalCourseYouCanTake += 1
            let course = canTakeCourses.removeFirst()
//            print("totalCourseYouCanTake: \(totalCourseYouCanTake) canTakeCourses: \(canTakeCourses), course: \(course), prerequisites: \(prerequisites)")
            
            
            if let dependents = dependentCourses[course] {
                dependents.forEach { takenCourse in
                    preReqRequired[takenCourse] -= 1
                    if preReqRequired[takenCourse] == 0 {
                        canTakeCourses.append(takenCourse)
                    }
                }
//                prerequisites[course].forEach { takenCourse in
//                    print(takenCourse)
//                    print("preReqRequired \(preReqRequired)")
//                    preReqRequired[takenCourse] -= 1
//                    if preReqRequired[takenCourse] == 0 {
//                        canTakeCourses += [takenCourse]
//                    }
//                }
            }
            
        }
//        print("success")
        
        return totalCourseYouCanTake >= numCourses
    }
    
//    private func buildGraph(_ prerequisites: [[Int]]) -> Course? {
//        
//        
//        return nil
//    }
}

//XCTAssertTrue(Solution().canFinish(2, [[1,0]]))
//XCTAssertFalse(Solution().canFinish(2, [[1,0],[0,1]]))
print(Solution().canFinish(5, [[1,4],[2,4],[3,1],[3,2]]))


