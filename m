From: Rich Felker <dalias@libc.org>
Date: Fri, 20 May 2016 02:53:03 +0000
Subject: [PATCH v2 02/12] of: add J-Core cpu bindings
Message-Id: <f3c89e4834665790ff13478c571cc9aaa9de5559.1463708766.git.dalias@libc.org>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1463708766.git.dalias@libc.org>
In-Reply-To: <cover.1463708766.git.dalias@libc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>

Signed-off-by: Rich Felker <dalias@libc.org>
---
 Documentation/devicetree/bindings/jcore/cpus.txt | 91 ++++++++++++++++++++++++
 1 file changed, 91 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/jcore/cpus.txt

diff --git a/Documentation/devicetree/bindings/jcore/cpus.txt b/Documentation/devicetree/bindings/jcore/cpus.txt
new file mode 100644
index 0000000..00ef112
--- /dev/null
+++ b/Documentation/devicetree/bindings/jcore/cpus.txt
@@ -0,0 +1,91 @@
+=========+J-Core cpu bindings
+=========+
+The J-Core processors are open source CPU cores that can be built as FPGA
+soft cores or ASICs. The device tree is also responsible for describing the
+cache controls and, for SMP configurations, all details of the SMP method,
+as documented below.
+
+
+---------------------
+Top-level "cpus" node
+---------------------
+
+Required properties:
+
+- #address-cells: Must be 1.
+
+- #size-cells: Must be 0.
+
+Optional properties:
+
+- enable-method: Required only for SMP systems. If present, must be
+  "jcore,spin-table".
+
+
+--------------------
+Individual cpu nodes
+--------------------
+
+Required properties:
+
+- device_type: Must be "cpu".
+
+- compatible: Must be "jcore,j2".
+
+- reg: Must be 0 on uniprocessor systems, or the sequential, zero-based
+  hardware cpu id on SMP systems.
+
+Optional properties:
+
+- clock-frequency: Clock frequency of the cpu in Hz.
+
+- cpu-release-addr: Necessary only for secondary processors on SMP systems
+  using the "jcore,spin-table" enable method. If present, must consist of
+  two cells containing physical addresses. The first cell contains an
+  address which, when written, unblocks the secondary cpu. The second cell
+  contains an address from which the cpu will read its initial program
+  counter when unblocked.
+
+
+---------------------
+Cache controller node
+---------------------
+
+Required properties:
+
+- compatible: Must be "jcore,cache".
+
+- reg: A memory range for the cache controller registers.
+
+
+--------
+IPI node
+--------
+
+Device trees for SMP systems must have an IPI node representing the mechanism
+used for inter-processor interrupt generation.
+
+Required properties:
+
+- compatible: Must be "jcore,ipi-controller".
+
+- reg: A memory range used to IPI generation.
+
+- interrupts: An irq on which IPI will be received.
+
+
+----------
+CPUID node
+----------
+
+Device trees for SMP systems must have a CPUID node representing the mechanism
+used to identify the current processor on which execution is taking place.
+
+Required properties:
+
+- compatible: Must be "jcore,cpuid-mmio".
+
+- reg: A memory range containing a single 32-bit mmio register which produces
+  the current cpu id when read.
-- 
2.8.1


