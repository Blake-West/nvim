
return { "nvim-telescope/telescope-fzf-native.nvim", 
  -- cmake isn't as native as make.. use make
  -- build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
  build = "make",
  dependencies = { "nvim-telescope/telescope.nvim" },
} 
