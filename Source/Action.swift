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
*
* Action
*
* Represents Action Nodes, which are repetitive relationships between Entity Nodes.
*/

import Foundation

@objc(Action)
public class Action: NSObject {
	internal let node: ManagedAction

	/**
	* init
	* Initializes Action with a given ManagedAction.
	* @param        entity: ManagedAction!
	*/
	internal init(action: ManagedAction!) {
		node = action
	}
	
	/**
	* init
	* An initializer for the wrapped Model Object with a given type.
	* @param        type: String!
	*/
	public convenience init(type: String) {
		self.init(action: ManagedAction(type: type))
	}
	
	/**
	* nodeClass
	* Retrieves the nodeClass for the Model Object that is wrapped internally.
	* @return       String
	*/
	public var nodeClass: String {
		return node.nodeClass
	}
	
	/**
	* type
	* Retrieves the type for the Model Object that is wrapped internally.
	* @return       String
	*/
	public var type: String {
		return node.type
	}
	
	/**
	* id
	* Retrieves the ID for the Model Object that is wrapped internally.
	* @return       String? of the ID
	*/
	public var id: String {
		var nodeURL: NSURL = node.objectID.URIRepresentation()
		var oID: String = nodeURL.lastPathComponent!
		return nodeClass + type + oID
	}
	
	/**
	* createdDate
	* Retrieves the date the Model Object was created.
	* @return       NSDate?
	*/
	public var createdDate: NSDate {
		return node.createdDate
	}
	
	/**
	* properties[ ]
	* Allows for Dictionary style coding, which maps to the wrapped Model Object property values.
	* @param        name: String!
	* get           Returns the property name value.
	* set           Value for the property name.
	*/
	public subscript(name: String) -> AnyObject? {
		get {
			return node[name]
		}
		set(value) {
			node[name] = value
		}
	}
	
	/**
	* addGroup
	* Adds a Group name to the list of Groups if it does not exist.
	* @param        name: String!
	* @return       Bool of the result, true if added, false otherwise.
	*/
	public func addGroup(name: String) -> Bool {
		return node.addGroup(name)
	}
	
	/**
	* hasGroup
	* Checks whether the Node is a part of the Group name passed or not.
	* @param        name: String!
	* @return       Bool of the result, true if is a part, false otherwise.
	*/
	public func hasGroup(name: String) -> Bool {
		return node.hasGroup(name)
	}
	
	/**
	* removeGroup
	* Removes a Group name from the list of Groups if it exists.
	* @param        name: String!
	* @return       Bool of the result, true if exists, false otherwise.
	*/
	public func removeGroup(name: String!) -> Bool {
		return node.removeGroup(name)
	}
	
	/**
	* groups
	* Retrieves the Groups the Node is a part of.
	* @return       Array<String>
	*/
	public var groups: Array<String> {
		get {
			var groups: Array<String> = Array<String>()
			for group in node.groupSet {
				groups.append(group.name)
			}
			return groups
		}
		set(value) {
			assert(false, "[GraphKit Error: Groups is not allowed to be set.]")
		}
	}
	
	/**
	* properties
	* Retrieves the Properties the Node is a part of.
	* @return       Dictionary<String, AnyObject?>
	*/
	public var properties: Dictionary<String, AnyObject?> {
		get {
			var properties: Dictionary<String, AnyObject?> = Dictionary<String, AnyObject>()
			for property in node.propertySet {
				properties[property.name] = property.value
			}
			return properties
		}
		set(value) {
			assert(false, "[GraphKit Error: Properties is not allowed to be set.]")
		}
	}
	
    /**
    * subjects
    * Retrieves an Array of Entity Objects.
    * @return       Array<Entity>
    */
    public var subjects: Array<Entity> {
        get {
            var nodes: Array<Entity> = Array<Entity>()
			for entry in node.subjectSet {
				nodes.append(Entity(entity: entry as! ManagedEntity))
			}
            return nodes
        }
        set(value) {
            assert(false, "[GraphKit Error: Subjects may not be set.]")
        }
    }

    /**
    * objects
    * Retrieves an Array of Entity Objects.
    * @return       Array<Entity>
    */
    public var objects: Array<Entity> {
        get {
            var nodes: Array<Entity> = Array<Entity>()
			for entry in node.objectSet {
				nodes.append(Entity(entity: entry as! ManagedEntity))
			}
            return nodes
        }
        set(value) {
            assert(false, "[GraphKit Error: Objects may not be set.]")
        }
    }

    /**
    * addSubject
    * Adds a Entity Model Object to the Subject Set.
    * @param        entity: Entity!
    * @return       Bool of the result, true if added, false otherwise.
    */
    public func addSubject(entity: Entity!) -> Bool {
        return node.addSubject(entity.node)
	}

    /**
    * removeSubject
    * Removes a Entity Model Object from the Subject Set.
    * @param        entity: Entity!
    * @return       Bool of the result, true if removed, false otherwise.
    */
    public func removeSubject(entity: Entity!) -> Bool {
		return node.removeSubject(entity.node)
    }
	
	/**
	* hasSubject
	* Checks if a Entity exists in the Subjects Set.
	* @param        entity: Entity!
	* @return       Bool of the result, true if exists, false otherwise.
	*/
	public func hasSubject(entity: Entity!) -> Bool {
		return contains(subjects, entity)
	}

    /**
    * addObject
    * Adds a Entity Object to the Object Set.
    * @param        entity: Entity!
    * @return       Bool of the result, true if added, false otherwise.
    */
    public func addObject(entity: Entity!) -> Bool {
        return node.addObject(entity.node)
    }

    /**
    * removeObject
    * Removes a Entity Model Object from the Object Set.
    * @param        entity: Entity!
    * @return       Bool of the result, true if removed, false otherwise.
    */
    public func removeObject(entity: Entity!) -> Bool {
		return node.removeObject(entity.node)
    }

	/**
	* hasObject
	* Checks if a Entity exists in the Objects Set.
	* @param        entity: Entity!
	* @return       Bool of the result, true if exists, false otherwise.
	*/
	public func hasObject(entity: Entity!) -> Bool {
		return contains(objects, entity)
	}
	
    /**
    * delete
    * Marks the Model Object to be deleted from the Graph.
    */
    public func delete() {
		node.delete()
    }
}

extension Action: Equatable, Printable {
	override public var description: String {
		return "{id: \((id)), type: \(type), groups: \(groups), properties: \(properties), subjects: \(subjects), objects: \(objects), createdDate: \(createdDate)}"
	}
}

public func ==(lhs: Action, rhs: Action) -> Bool {
	return lhs.id == rhs.id
}