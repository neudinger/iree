// RUN: iree-compile --compile-to=preprocessing \
// RUN:   --iree-hal-target-device=cuda --iree-cuda-target=sm_120 %s \
// RUN: | FileCheck %s --check-prefix=SM120

// RUN: iree-compile --compile-to=preprocessing \
// RUN:   --iree-hal-target-device=cuda --iree-cuda-target=sm_100f %s \
// RUN: | FileCheck %s --check-prefix=SM100F

// RUN: not iree-compile --compile-to=preprocessing \
// RUN:   --iree-hal-target-device=cuda --iree-cuda-target=sm_999 %s \
// RUN:   2>&1 | FileCheck %s --check-prefix=UNKNOWN

// SM120: #hal.executable.target<"cuda", "cuda-nvptx-fb"
// SM120: arch = "sm_120"
// SM120: subgroup_size_choices = [32]
// SM120: max_workgroup_memory_bytes = 101376

// SM100F: #hal.executable.target<"cuda", "cuda-nvptx-fb"
// SM100F: arch = "sm_100f"
// SM100F: max_workgroup_memory_bytes = 232448

// UNKNOWN: Unknown CUDA target 'sm_999'

module {
  util.func public @foo(%arg0: tensor<?xf32>) -> tensor<?xf32> {
    util.return %arg0 : tensor<?xf32>
  }
}
