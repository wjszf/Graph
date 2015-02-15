/**
* Copyright (C) 2015 GraphKit, Inc. <http://graphkit.io> and other GraphKit contributors.
*
* This program is free software: you can redistribute it and/or modify
* it under the terms of the GNU Affero General Public License as published
* by the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU Affero General Public License for more details.
*
* You should have received a copy of the GNU Affero General Public License
* along with this program located at the root of the software package
* in a file called LICENSE.  If not, see <http://www.gnu.org/licenses/>.
*/

import CoreData

@objc(GKManagedEntity)
internal class GKManagedEntity : GKManagedNode {
    convenience internal init(type: String!) {
        let graph: GKGraph = GKGraph()
        let entitiDescription: NSEntityDescription! = NSEntityDescription.entityForName(GKGraphUtility.entityEntityDescriptionName, inManagedObjectContext: graph.managedObjectContext)

        self.init(entity: entitiDescription, insertIntoManagedObjectContext: graph.managedObjectContext)
        nodeClass = "GKEntity"
        self.type = type
        createdDate = NSDate()
        properties = Dictionary<String, AnyObject>()
    }

    class func entityDescription() -> NSEntityDescription! {
        let graph: GKGraph = GKGraph()
        return NSEntityDescription.entityForName(GKGraphUtility.entityEntityDescriptionName, inManagedObjectContext: graph.managedObjectContext)
    }
}