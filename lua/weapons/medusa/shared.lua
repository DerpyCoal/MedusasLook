// By Lavacoal123

SWEP.AdminSpawnable = true                          // Is the swep spawnable for admin 
SWEP.ViewModelFOV = 64                              // How much of the weapon do u see ?
SWEP.ViewModel = "models/weapons/v_hands.mdl"
SWEP.WorldModel = "models/weapons/w_pistol.mdl"
SWEP.AutoSwitchTo = false                           // When someone walks over the swep, should I automatically change to your swep ?
SWEP.Slot = 0                                       // Deside wich slot you want your swep do be in 1 2 3 4 5 6
SWEP.HoldType = "Pistol"                            // How the swep is hold Pistol smg greanade melee
SWEP.PrintName = "Medusa's Look"                         // your sweps name
SWEP.Author = "Lavacoal123"                            // Your name
SWEP.Spawnable = true                               //  Can everybody spawn this swep ? - If you want only admin keep this false and adminsapwnable true.
SWEP.AutoSwitchFrom = false                         // Does the weapon get changed by other sweps if you pick them up ?
SWEP.FiresUnderwater = false                        // Does your swep fire under water ?
SWEP.Weight = 5                                     // Chose the weight of the Swep
SWEP.DrawCrosshair = true                           // Do you want it to have a crosshair ?
SWEP.Category = "Coal's Sweps"                      // Make your own catogory for the swep
SWEP.SlotPos = 0                                    // Deside wich slot you want your swep do be in 1 2 3 4 5 6
SWEP.DrawAmmo = true                                // Does the ammo show up when you are using it ? True / False
SWEP.ReloadSound = "Weapon_Pistol.Reload"           // Reload sound, you can use the default ones, or you can use your one; Example; "sound/myswepreload.waw"
SWEP.Instructions = "Look at any entity."              // How do pepole use your swep ?
SWEP.Contact = "coalstudios95@gmail.com"                     // How Pepole chould contact you if they find bugs, errors, etc
SWEP.Purpose = "Look at any entity, it dies!"          // What is the purpose with this swep ?
SWEP.base = "weapon_base"
//General settings\\


//SWEP:Initialize()\\
function SWEP:Initialize()
	if ( IsValid(self.Owner) ) then
		self.Owner:EmitSound("medusa.ogg")
	end
	if ( SERVER ) then
		self:SetWeaponHoldType( self.HoldType )
	end
end
//SWEP:Initialize()\\

//SWEP:PrimaryFire()\\
function SWEP:PrimaryAttack()
end
//SWEP:PrimaryFire()\\

function SWEP:Think()
	if ( IsValid(self.Owner) ) then
		local entcross = self.Owner:GetEyeTrace().Entity
		if ( IsValid(entcross) ) and ( not entcross:IsWorld() ) then
			self.Owner:EmitSound("medusa.ogg")
			local explode = ents.Create("env_explosion")
			explode:SetPos( entcross:GetPos() )
			explode:SetOwner( self.Owner )
			entcross:Remove()
			explode:Spawn()
			explode:SetKeyValue("iMagnitude","150")
			explode:Fire("Explode", 0, 0 )
			explode:EmitSound("weapon_AWP.Single", 400, 400 )
		end
	end
end
