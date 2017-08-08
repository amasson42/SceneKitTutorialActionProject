//
//  SCNUtils.swift
//  ComeOneLetsGoAndPlay
//
//  Created by Arthur Masson on 08/08/2017.
//  Copyright © 2017 Giantwow. All rights reserved.
//

import SceneKit

//
//  SCNUtils.swift
//  libgeoswift
//
//  Created by Arthur Masson on 03/01/2017.
//  Copyright © 2017 Arthur Masson. All rights reserved.
//

import SceneKit

extension SCNVector3 { /* as point */
    
    func distanceWith(point: SCNVector3) -> CGFloat {
        return sqrt(self.squaredDistanceWith(point: point))
    }
    
    func squaredDistanceWith(point p: SCNVector3) -> CGFloat {
        return (self.x - p.x) * (self.x - p.x) + (self.y - p.y) * (self.y - p.y) + (self.z - p.z) * (self.z - p.z)
    }
    
    func symmetric(ofPoint p: SCNVector3) -> SCNVector3 {
        var s = p
        s += SCNVector3(start: p, end: self) * 2
        return s
    }
    
    func symmetric(ofVector v: SCNVector3) -> SCNVector3 {
        return -v
    }
}

extension SCNVector3 { /* as vector */
    
    init(start a: SCNVector3, end b: SCNVector3) {
        (self.x, self.y, self.z) = (b.x - a.x, b.y - a.y, b.z - a.z)
    }
    
    init(vectorialProduce u: SCNVector3, _ v: SCNVector3) {
        (self.x, self.y, self.z) = (u.y * v.z - u.z * v.y, u.z * v.x - u.x * v.z, u.x * v.y - u.y * v.x)
    }
    
    /* Getters */
    
    var norme: CGFloat {
        get {
            return sqrt(self.squaredNorme)
        }
        set {
            let t = newValue / self.norme
            self.x *= t
            self.y *= t
            self.z *= t
        }
    }
    
    var squaredNorme: CGFloat {
        get {
            return self.x * self.x + self.y * self.y + self.z * self.z
        }
        set {
            let t = sqrt(newValue / self.squaredNorme)
            self.x *= t
            self.y *= t
            self.z *= t
        }
    }
    
    var isNul: Bool {
        get {
            return self.x == 0
                && self.y == 0
                && self.z == 0
        }
        set {
            if newValue {
                (self.x, self.y, self.z) = (0, 0, 0)
            }
        }
    }
    
    func isColineaireWith(vector v: SCNVector3) -> Bool {
        return self.x * v.y == self.y * v.x
            && self.y * v.z == self.z * v.y
            && self.z * v.z == self.x * v.z
    }
    
    func scalar(vector v: SCNVector3) -> CGFloat {
        return self.x * v.x + self.y * v.y + self.z * v.z
    }
    
    func vectorial(vector v: SCNVector3) -> SCNVector3 {
        return SCNVector3(vectorialProduce: self, v)
    }
    
    func rotate(vector v: SCNVector3, by alpha: CGFloat) -> SCNVector3 {
        return SCNMatrix4(rotaxe: self, alpha: alpha).transform(vector: v)
    }
    
    /* Methodes */
    
    mutating func normalize() {
        let norme: CGFloat = self.norme
        self.x /= norme
        self.y /= norme
        self.z /= norme
    }
}

/* SCNVector3 operators */

prefix func +(hs: SCNVector3) -> SCNVector3 {
    return SCNVector3(+hs.x, +hs.y, +hs.z)
}

prefix func -(hs: SCNVector3) -> SCNVector3 {
    return SCNVector3(-hs.x, -hs.y, -hs.z)
}

func +=(lhs: inout SCNVector3, rhs: SCNVector3) {
    lhs.x += rhs.x
    lhs.y += rhs.y
    lhs.z += rhs.z
}

func -=(lhs: inout SCNVector3, rhs: SCNVector3) {
    lhs.x -= rhs.x
    lhs.y -= rhs.y
    lhs.z -= rhs.z
}

func *=(lhs: inout SCNVector3, rhs: CGFloat) {
    lhs.x *= rhs
    lhs.y *= rhs
    lhs.z *= rhs
}

func /=(lhs: inout SCNVector3, rhs: CGFloat) {
    lhs.x /= rhs
    lhs.y /= rhs
    lhs.z /= rhs
}

func +(lhs: SCNVector3, rhs: SCNVector3) -> SCNVector3 {
    var r = lhs
    r += rhs
    return r
}

func -(lhs: SCNVector3, rhs: SCNVector3) -> SCNVector3 {
    var r = lhs
    r -= rhs
    return r
}

func *(lhs: CGFloat, rhs: SCNVector3) -> SCNVector3 {
    var r = rhs
    r *= lhs
    return r
}

func *(lhs: SCNVector3, rhs: CGFloat) -> SCNVector3 {
    var r = lhs
    r *= rhs
    return r
}

func /(lhs: SCNVector3, rhs: CGFloat) -> SCNVector3 {
    var r = lhs
    r /= rhs
    return r
}

func *(lhs: SCNVector3, rhs: SCNVector3) -> CGFloat {
    return lhs.scalar(vector: rhs)
}

func ^(lhs: SCNVector3, rhs: SCNVector3) -> SCNVector3 {
    return SCNVector3(vectorialProduce: lhs, rhs)
}

func ==(lhs: SCNVector3, rhs: SCNVector3) -> Bool {
    return lhs.x == rhs.x && lhs.y == rhs.y && lhs.z == rhs.z
}

func !=(lhs: SCNVector3, rhs: SCNVector3) -> Bool {
    return !(lhs == rhs)
}

/* Transformations matrix */

func inverseRepere(axes x: inout SCNVector3, _ y: inout SCNVector3, _ z: inout SCNVector3) -> Bool {
    let t = x.x * (y.y * z.z - y.z * z.y)
        - x.y * (y.x * z.z - y.z * z.x)
        + x.z * (y.x * z.y - y.y * z.x)
    if t == 0 {
        return false
    }
    var d = [SCNVector3Zero, SCNVector3Zero, SCNVector3Zero]
    d[0].x = (y.y * z.z - y.z * z.y) / t
    d[0].y = (x.z * z.y - x.y * z.z) / t
    d[0].z = (x.y * y.z - x.z * y.y) / t
    d[1].x = (y.z * z.x - y.x * z.z) / t
    d[1].y = (x.x * z.z - x.z * z.x) / t
    d[1].z = (x.z * y.x - x.x * y.z) / t
    d[2].x = (y.x * z.y - y.y * z.x) / t
    d[2].y = (x.y * z.x - x.x * z.y) / t
    d[2].z = (x.x * y.y - x.y * y.x) / t
    x = d[0]
    y = d[1]
    z = d[2]
    return true
}

extension SCNMatrix4 {
    
    /* Creators */
    
    init(axe_x: SCNVector3, axe_y: SCNVector3, axe_z: SCNVector3, origin: SCNVector3 = SCNVector3(0, 0, 0)) {
        (self.m11, self.m12, self.m13) = (axe_x.x, axe_x.y, axe_x.z)
        (self.m21, self.m22, self.m23) = (axe_y.x, axe_y.y, axe_y.z)
        (self.m31, self.m32, self.m33) = (axe_z.x, axe_z.y, axe_z.z)
        (self.m14, self.m24, self.m34) = (origin.x, origin.y, origin.z)
        (self.m41, self.m42, self.m43, self.m44) = (0, 0, 0, 1)
    }
    
    /* Getters */
    
    var eigenVector: SCNVector3 {
        get {
            return SCNVector3(self.m32 - self.m23,
                              self.m13 - self.m31,
                              self.m21 - self.m12)
        }
    }
    
    var axe_x: SCNVector3 {
        get {
            return SCNVector3(self.m11, self.m12, self.m13)
        }
        set {
            (self.m11, self.m12, self.m13) = (newValue.x, newValue.y, newValue.z)
        }
    }
    
    var axe_y: SCNVector3 {
        get {
            return SCNVector3(self.m21, self.m22, self.m23)
        }
        set {
            (self.m21, self.m22, self.m23) = (newValue.x, newValue.y, newValue.z)
        }
    }
    
    var axe_z: SCNVector3 {
        get {
            return SCNVector3(self.m31, self.m32, self.m33)
        }
        set {
            (self.m31, self.m32, self.m33) = (newValue.x, newValue.y, newValue.z)
        }
    }
    
    var origin: SCNVector3 {
        get {
            return SCNVector3(self.m14, self.m24, self.m34)
        }
        set {
            (self.m14, self.m24, self.m34) = (newValue.x, newValue.y, newValue.z)
        }
    }
    
    var inverse: SCNMatrix4 {
        get {
            var r = SCNMatrix4(axe_x: self.axe_x, axe_y: self.axe_y, axe_z: self.axe_z)
            if inverseRepere(axes: &r.axe_x, &r.axe_y, &r.axe_z) {
                r.origin = r.transform(point: -self.origin)
                return r
            }
            return SCNMatrix4Identity
        }
    }
    
    /* Users */
    
    func transform(point p: SCNVector3) -> SCNVector3 {
        return SCNVector3(p.x * self.m11 + p.y * self.m12 + p.z * self.m13 + self.m14,
                          p.x * self.m21 + p.y * self.m22 + p.z * self.m23 + self.m24,
                          p.x * self.m31 + p.y * self.m32 + p.z * self.m33 + self.m34);
    }
    
    func transform(vector v: SCNVector3) -> SCNVector3 {
        return SCNVector3(v.x * self.m11 + v.y * self.m12 + v.z * self.m13,
                          v.x * self.m21 + v.y * self.m22 + v.z * self.m23,
                          v.x * self.m31 + v.y * self.m32 + v.z * self.m33);
    }
    
    func transform(matrix m: SCNMatrix4) -> SCNMatrix4 {
        return SCNMatrix4Mult(self, m)
    }
    
    /* Methodes */
    
    mutating func normalize() {
        self.axe_x.normalize()
        self.axe_y.normalize()
        self.axe_z.normalize()
    }
    
    /* Basics values */
    
    init(transl t: SCNVector3) {
        (self.m11, self.m12, self.m13) = (1, 0, 0)
        (self.m21, self.m22, self.m23) = (0, 1, 0)
        (self.m31, self.m32, self.m33) = (0, 0, 1)
        (self.m14, self.m24, self.m34) = (t.x, t.y, t.z)
        (self.m41, self.m42, self.m43, self.m44) = (0, 0, 0, 1)
    }
    
    init(scale s: SCNVector3) {
        (self.m11, self.m12, self.m13) = (s.x, 0, 0)
        (self.m21, self.m22, self.m23) = (0, s.y, 0)
        (self.m31, self.m32, self.m33) = (0, 0, s.z)
        (self.m14, self.m24, self.m34) = (0, 0, 0)
        (self.m41, self.m42, self.m43, self.m44) = (0, 0, 0, 1)
    }
    
    init(rotx alpha: CGFloat) {
        let s = sin(alpha)
        let c = cos(alpha)
        (self.m11, self.m12, self.m13) = (1, 0, 0)
        (self.m21, self.m22, self.m23) = (0, c, -s)
        (self.m31, self.m32, self.m33) = (0, s, c)
        (self.m14, self.m24, self.m34) = (0, 0, 0)
        (self.m41, self.m42, self.m43, self.m44) = (0, 0, 0, 1)
    }
    
    init(roty alpha: CGFloat) {
        let s = sin(alpha)
        let c = cos(alpha)
        (self.m11, self.m12, self.m13) = (c, 0, s)
        (self.m21, self.m22, self.m23) = (0, 1, 0)
        (self.m31, self.m32, self.m33) = (-s, 0, c)
        (self.m14, self.m24, self.m34) = (0, 0, 0)
        (self.m41, self.m42, self.m43, self.m44) = (0, 0, 0, 1)
    }
    
    init(rotz alpha: CGFloat) {
        let s = sin(alpha)
        let c = cos(alpha)
        (self.m11, self.m12, self.m13) = (c, -s, 0)
        (self.m21, self.m22, self.m23) = (s, c, 0)
        (self.m31, self.m32, self.m33) = (0, 0, 1)
        (self.m14, self.m24, self.m34) = (0, 0, 0)
        (self.m41, self.m42, self.m43, self.m44) = (0, 0, 0, 1)
    }
    
    init(rotaxe axe: SCNVector3, alpha: CGFloat) {
        let norme = axe.norme
        let x = axe.x / norme;
        let y = axe.y / norme;
        let z = axe.z / norme;
        let s = sin(alpha)
        let lc = 1 - cos(alpha)
        (self.m11, self.m12, self.m13) = (x * x * lc + 1 - lc, y * x * lc - z * s, z * x * lc + y * s)
        (self.m21, self.m22, self.m23) = (x * y * lc + z * s, y * y * lc + 1 - lc, z * y * lc - x * s)
        (self.m31, self.m32, self.m33) = (x * z * lc - y * s, y * z * lc + x * s, z * z * lc + 1 - lc)
        (self.m14, self.m24, self.m34) = (0, 0, 0)
        (self.m41, self.m42, self.m43, self.m44) = (0, 0, 0, 1)
    }
    
    init(rotaxe axe: SCNVector3) {
        self.init(rotaxe: axe, alpha: axe.norme)
    }
    
    init(rotaxe axe: SCNVector4) {
        self.init(rotaxe: SCNVector3(axe.x, axe.y, axe.z), alpha: axe.w)
    }
    
    init(skewSymCrossProductOf axe: SCNVector3) {
        let v = axe / axe.norme
        (self.m11, self.m12, self.m13) = (0, -v.z, v.y)
        (self.m21, self.m22, self.m23) = (v.z, 0, -v.x)
        (self.m31, self.m32, self.m33) = (-v.y, v.x, 0)
        (self.m14, self.m24, self.m34) = (0, 0, 0)
        (self.m41, self.m42, self.m43, self.m44) = (0, 0, 0, 1)
    }
}

/* SCNMatrix4 operators */

func +=(lhs: inout SCNMatrix4, rhs: SCNMatrix4) {
    lhs.m11 += rhs.m11
    lhs.m12 += rhs.m12
    lhs.m13 += rhs.m13
    lhs.m14 += rhs.m14
    lhs.m21 += rhs.m21
    lhs.m22 += rhs.m22
    lhs.m23 += rhs.m23
    lhs.m24 += rhs.m24
    lhs.m31 += rhs.m31
    lhs.m32 += rhs.m32
    lhs.m33 += rhs.m33
    lhs.m34 += rhs.m34
    lhs.m41 += rhs.m41
    lhs.m42 += rhs.m42
    lhs.m43 += rhs.m43
    lhs.m44 += rhs.m44
}

func -=(lhs: inout SCNMatrix4, rhs: SCNMatrix4) {
    lhs.m11 -= rhs.m11
    lhs.m12 -= rhs.m12
    lhs.m13 -= rhs.m13
    lhs.m14 -= rhs.m14
    lhs.m21 -= rhs.m21
    lhs.m22 -= rhs.m22
    lhs.m23 -= rhs.m23
    lhs.m24 -= rhs.m24
    lhs.m31 -= rhs.m31
    lhs.m32 -= rhs.m32
    lhs.m33 -= rhs.m33
    lhs.m34 -= rhs.m34
    lhs.m41 -= rhs.m41
    lhs.m42 -= rhs.m42
    lhs.m43 -= rhs.m43
    lhs.m44 -= rhs.m44
}

func +=(lhs: inout SCNMatrix4, rhs: SCNVector3) {
    lhs.m14 += rhs.x
    lhs.m24 += rhs.y
    lhs.m34 += rhs.z
}

func -=(lhs: inout SCNMatrix4, rhs: SCNVector3) {
    lhs.m14 -= rhs.x
    lhs.m24 -= rhs.y
    lhs.m34 -= rhs.z
}

func *=(lhs: inout SCNMatrix4, rhs: SCNMatrix4) {
    lhs = lhs.transform(matrix: rhs)
}

func *=(lhs: inout SCNMatrix4, rhs: CGFloat) {
    lhs.m11 *= rhs
    lhs.m12 *= rhs
    lhs.m13 *= rhs
    lhs.m14 *= rhs
    lhs.m21 *= rhs
    lhs.m22 *= rhs
    lhs.m23 *= rhs
    lhs.m24 *= rhs
    lhs.m31 *= rhs
    lhs.m32 *= rhs
    lhs.m33 *= rhs
    lhs.m34 *= rhs
    lhs.m41 *= rhs
    lhs.m42 *= rhs
    lhs.m43 *= rhs
    lhs.m44 *= rhs
}

func /=(lhs: inout SCNMatrix4, rhs: CGFloat) {
    lhs.m11 /= rhs
    lhs.m12 /= rhs
    lhs.m13 /= rhs
    lhs.m14 /= rhs
    lhs.m21 /= rhs
    lhs.m22 /= rhs
    lhs.m23 /= rhs
    lhs.m24 /= rhs
    lhs.m31 /= rhs
    lhs.m32 /= rhs
    lhs.m33 /= rhs
    lhs.m34 /= rhs
    lhs.m41 /= rhs
    lhs.m42 /= rhs
    lhs.m43 /= rhs
    lhs.m44 /= rhs
}

func +(lhs: SCNMatrix4, rhs: SCNVector3) -> SCNMatrix4 {
    var r = lhs
    r += rhs
    return r
}

func -(lhs: SCNMatrix4, rhs: SCNVector3) -> SCNMatrix4 {
    var r = lhs
    r -= rhs
    return r
}

func +(lhs: SCNMatrix4, rhs: SCNMatrix4) -> SCNMatrix4 {
    var r = lhs
    r += rhs
    return r
}

func -(lhs: SCNMatrix4, rhs: SCNMatrix4) -> SCNMatrix4 {
    var r = rhs
    r -= rhs
    return r
}

func *(lhs: SCNMatrix4, rhs: SCNVector3) -> SCNVector3 {
    return lhs.transform(point: rhs)
}

func *(lhs: SCNMatrix4, rhs: SCNMatrix4) -> SCNMatrix4 {
    return lhs.transform(matrix: rhs)
}

func *(lhs: SCNMatrix4, rhs: CGFloat) -> SCNMatrix4 {
    var r = lhs
    r *= rhs
    return r
}

func *(lhs: CGFloat, rhs: SCNMatrix4) -> SCNMatrix4 {
    var r = rhs
    r *= lhs
    return r
}

func /(lhs: SCNMatrix4, rhs: CGFloat) -> SCNMatrix4 {
    var r = lhs
    r /= rhs
    return r
}

extension SCNVector3: CustomStringConvertible {
    public var description: String {
        return "(\(self.x);\(self.y);\(self.z))"
    }
}

extension SCNMatrix4: CustomStringConvertible {
    public var description: String {
        let strs: [[String]] = [
            ["\(self.m11)", "\(self.m21)", "\(self.m31)", "\(self.m41)"],
            ["\(self.m12)", "\(self.m22)", "\(self.m32)", "\(self.m42)"],
            ["\(self.m13)", "\(self.m23)", "\(self.m33)", "\(self.m43)"],
            ["\(self.m14)", "\(self.m24)", "\(self.m34)", "\(self.m44)"]]
        var maxLen : [Int] = []
        for i in 0 ..< strs.count {
            maxLen.append(strs[i].max {
                $0.characters.count < $1.characters.count
                }!.characters.count)
        }
        var ret = ""
        for y in 0 ..< strs.count {
            ret += "[ "
            for x in 0 ..< strs[y].count {
                ret += "\(strs[x][y])"
                for _ in strs[x][y].characters.count ... maxLen[x] {
                    ret += " "
                }
            }
            ret += "]\n"
        }
        return ret
    }
}
