import Foundation

/// The de facto implementation of the Euclidean protocol
public
struct Euclid: Euclidean {
    /// The number of slots in space
    public
    var resolution: Int {
        didSet { resolutionWasSet(&self) }
    }
    
    /// The number of particles present in space
    public
    var density: Int {
        didSet { densityWasSet(&self) }
    }
    
    /// The offset of the particles in space
    public
    var phase: Int {
        didSet { phaseWasSet(&self) }
    }
    
    /// Create a Euclid initialized with resolution, density, and phase.
    public
    init?(resolution: Int, density: Int, phase: Int) {
        if resolution < 0 || density < 0 || density > resolution || phase < 0 || phase >= resolution  {
            return nil
        }
        
        self.resolution = resolution
        self.density = density
        self.phase = phase
    }
}

public
extension Euclid {
    /// Create a Euclid with all values initialized to zero.
    public
    init() {
        self.resolution = 0
        self.density = 0
        self.phase = 0
    }
}

/// Clamps argument's resolution to range, 0 <= n.
private
func resolutionWasSet(inout euclid: Euclid) {
    if euclid.resolution < 0 {
        euclid.resolution = 0
    }
}

/// Clamps argument's density to range, 0 <= n <= resolution.
private
func densityWasSet(inout euclid: Euclid) {
    if euclid.density < 0 {
        euclid.density = 0
    }
    else if euclid.density > euclid.resolution {
        euclid.density = euclid.resolution
    }
}

/// Clamps argument's density to range, 0 <= n < resolution.
private
func phaseWasSet(inout euclid: Euclid) {
    euclid.phase %= euclid.resolution
    
    if euclid.phase < 0 {
        euclid.phase += euclid.resolution
    }
}

extension Euclid: Equatable {}

/// Two `Euclid`s are equal if their `resolution`, `density`, and `phase` are equal.
public
func == (lhs: Euclid, rhs: Euclid) -> Bool {
    if lhs.resolution == rhs.resolution && lhs.density == rhs.density && lhs.phase == rhs.phase {
        return true
    }
    
    return false
}

