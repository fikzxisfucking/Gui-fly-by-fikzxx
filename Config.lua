--[[
    ═══════════════════════════════════════════════════
    CONFIGURATION FILE - GUI FLY BY FIKZXX
    ═══════════════════════════════════════════════════
    
    Edit nilai di bawah ini untuk mengatur script
    sesuai keinginan Anda.
--]]

return {
    -- ============================================================
    -- UI SETTINGS
    -- ============================================================
    UI = {
        -- Warna tema utama (RGB)
        ThemeColor = Color3.fromRGB(0, 170, 255),
        
        -- Transparansi background (0 = solid, 1 = transparan)
        BackgroundTransparency = 0.08,
        
        -- Ukuran border
        BorderSize = 2,
        
        -- Radius sudut (rounded corners)
        CornerRadius = 8,
        
        -- Ukuran GUI
        Size = {
            Width = 320,
            Height = 220,
        },
        
        -- Posisi GUI (persentase layar)
        Position = {
            X = 0.5,  -- Center
            Y = 0.3,  -- Sedikit di atas tengah
        },
    },
    
    -- ============================================================
    -- FLY SETTINGS
    -- ============================================================
    Fly = {
        -- Kecepatan default saat script dimuat
        DefaultSpeed = 50,
        
        -- Kecepatan minimum
        MinSpeed = 1,
        
        -- Kecepatan maksimum
        MaxSpeed = 100,
        
        -- Gaya maksimum (jangan diubah kecuali tahu efeknya)
        MaxForce = 100000,
        
        -- Auto-start fly saat script dijalankan
        AutoStart = false,
    },
    
    -- ============================================================
    -- FEATURES (Coming Soon)
    -- ============================================================
    Features = {
        -- Efek transisi halus
        EnableSmoothTransition = true,
        
        -- Efek partikel saat terbang
        EnableParticles = false,
        
        -- Efek suara
        EnableSound = false,
        
        -- Auto-land ketika dekat tanah
        AutoLand = false,
    },
    
    -- ============================================================
    -- DEVELOPER INFO
    -- ============================================================
    Developer = {
        Name = "Fikzxx",
        Version = "2.0.0",
        GitHub = "https://github.com/Fikzxx/GUI-Fly",
        Discord = "Fikzxx#0001",
    },
}
