// By Lavacoal123

SWEP.AdminOnly = true                          // Is the swep spawnable for admin 
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
SWEP.Weight = 5                                     // Chose the weight of the Swep
SWEP.DrawCrosshair = true                           // Do you want it to have a crosshair ?
SWEP.Category = "Coal's Sweps"                      // Make your own catogory for the swep
SWEP.SlotPos = 0                                    // Deside wich slot you want your swep do be in 1 2 3 4 5 6
SWEP.Instructions = "Look at any entity."              // How do pepole use your swep ?
SWEP.Contact = "coalstudios95@gmail.com"                     // How Pepole chould contact you if they find bugs, errors, etc
SWEP.Purpose = "Look at any entity, it dies!"          // What is the purpose with this swep ?

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Ammo = ""
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Ammo = ""

SWEP.IgniteCooldown = 0.5

function SWEP:Initialize()			
	self:SetHoldType(self.HoldType)
end

function SWEP:SetupDataTables()
	self:DTVar("Float", 0, "NextIgnite")
end

function SWEP:Deploy()
	if (self.Owner == NULL) then
		return false
	end

	self.Owner:EmitSound("medusa.ogg")

	return true
end

function SWEP:PrimaryAttack()
end

function SWEP:SecondaryAttack()
end

function SWEP:Reload()
end

if (SERVER) then
	function SWEP:Think()
		local flCurTime = CurTime()

		if (self.dt.NextIgnite <= flCurTime and self.Owner ~= NULL) then
			local entcross = self.Owner:GetEyeTrace().Entity

			-- World:IsValid() returns false
			if (entcross:IsValid()) then
				self.Owner:EmitSound("medusa.ogg")

				local explode = ents.Create("env_explosion")
				explode:SetPos(entcross:GetPos())
				explode:SetOwner(self.Owner)
				explode:Spawn()
				explode:SetKeyValue("iMagnitude","150")
				explode:Fire("Explode", 0, 0 )
				explode:EmitSound("Weapon_AWP.Single", 400, 400 )

				if (entcross:IsPlayer() or entcross:IsNPC()) then
					entcross:Kill()
				else
					entcross:Remove()
				end
				
				self.dt.NextIgnite = flCurTime + self.IgniteCooldown
			end
		end
	end
end
