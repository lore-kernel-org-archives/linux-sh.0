From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Date: Tue, 18 Nov 2008 15:49:03 +0000
Subject: [PATCH - UPDATED]  - Fix dreamcast irq.c formatting
Message-Id: <20081118174927.803cbfd6.kristoffer.ericson@gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Signature=_Tue__18_Nov_2008_17_49_27_+0100_zdCEftDb.gKHeAe7"
List-Id: <linux-sh.vger.kernel.org>
To: linux-sh@vger.kernel.org

--Signature=_Tue__18_Nov_2008_17_49_27_+0100_zdCEftDb.gKHeAe7
Content-Type: multipart/mixed;
 boundary="Multipart=_Tue__18_Nov_2008_17_49_27_+0100_DNHtcQ1DYJ2ktUX9"


--Multipart=_Tue__18_Nov_2008_17_49_27_+0100_DNHtcQ1DYJ2ktUX9
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This patch cleans the bad formatting
found in mach-dreamcast/irq.c file.

Signed-off-by: Kristoffer Ericson <Kristoffer.Ericson@gmail.com>

diff --git a/arch/sh/boards/mach-dreamcast/irq.c b/arch/sh/boards/mach-drea=
mcast/irq.c
index 67bdc33..36a8a08 100644
--- a/arch/sh/boards/mach-dreamcast/irq.c
+++ b/arch/sh/boards/mach-dreamcast/irq.c
@@ -14,31 +14,32 @@
 #include <asm/irq.h>
 #include <mach/sysasic.h>
=20
-/* Dreamcast System ASIC Hardware Events -
-
-   The Dreamcast's System ASIC (a.k.a. Holly) is responsible for receiving
-   hardware events from system peripherals and triggering an SH7750 IRQ.
-   Hardware events can trigger IRQs 13, 11, or 9 depending on which bits a=
re
-   set in the Event Mask Registers (EMRs).  When a hardware event is
-   triggered, it's corresponding bit in the Event Status Registers (ESRs)
-   is set, and that bit should be rewritten to the ESR to acknowledge that
-   event.
-
-   There are three 32-bit ESRs located at 0xa05f8900 - 0xa05f6908.  Event
-   types can be found in include/asm-sh/dreamcast/sysasic.h. There are thr=
ee
-   groups of EMRs that parallel the ESRs.  Each EMR group corresponds to an
-   IRQ, so 0xa05f6910 - 0xa05f6918 triggers IRQ 13, 0xa05f6920 - 0xa05f6928
-   triggers IRQ 11, and 0xa05f6930 - 0xa05f6938 triggers IRQ 9.
-
-   In the kernel, these events are mapped to virtual IRQs so that drivers =
can
-   respond to them as they would a normal interrupt.  In order to keep this
-   mapping simple, the events are mapped as:
-
-   6900/6910 - Events  0-31, IRQ 13
-   6904/6924 - Events 32-63, IRQ 11
-   6908/6938 - Events 64-95, IRQ  9
-
-*/
+/*
+ * Dreamcast System ASIC Hardware Events
+ *
+ * The Dreamcast's System ASIC (a.k.a. Holly) is responsible for receiving
+ * hardware events from system peripherals and triggering an SH7750 IRQ.
+ * Hardware events can trigger IRQs 13, 11, or 9 depending on which bits a=
re
+ * set in the Event Mask Registers (EMRs).  When a hardware event is
+ * triggered, it's corresponding bit in the Event Status Registers (ESRs)
+ * is set, and that bit should be rewritten to the ESR to acknowledge that
+ * event.
+ *
+ * There are three 32-bit ESRs located at 0xa05f8900 - 0xa05f6908.  Event
+ * types can be found in include/asm-sh/dreamcast/sysasic.h. There are thr=
ee
+ * groups of EMRs that parallel the ESRs.  Each EMR group corresponds to an
+ * IRQ, so 0xa05f6910 - 0xa05f6918 triggers IRQ 13, 0xa05f6920 - 0xa05f6928
+ * triggers IRQ 11, and 0xa05f6930 - 0xa05f6938 triggers IRQ 9.
+ *
+ * In the kernel, these events are mapped to virtual IRQs so that drivers =
can
+ * respond to them as they would a normal interrupt.  In order to keep this
+ * mapping simple, the events are mapped as:
+ *
+ * 6900/6910 - Events  0-31, IRQ 13
+ * 6904/6924 - Events 32-63, IRQ 11
+ * 6908/6938 - Events 64-95, IRQ  9
+ *
+ */
=20
 #define ESR_BASE 0x005f6900    /* Base event status register */
 #define EMR_BASE 0x005f6910    /* Base event mask register */
@@ -56,60 +57,60 @@
 /* Disable the hardware event by masking its bit in its EMR */
 static inline void disable_systemasic_irq(unsigned int irq)
 {
-        __u32 emr =3D EMR_BASE + (LEVEL(irq) << 4) + (LEVEL(irq) << 2);
-        __u32 mask;
+	__u32 emr =3D EMR_BASE + (LEVEL(irq) << 4) + (LEVEL(irq) << 2);
+	__u32 mask;
=20
-        mask =3D inl(emr);
-        mask &=3D ~(1 << EVENT_BIT(irq));
-        outl(mask, emr);
+	mask =3D inl(emr);
+	mask &=3D ~(1 << EVENT_BIT(irq));
+	outl(mask, emr);
 }
=20
 /* Enable the hardware event by setting its bit in its EMR */
 static inline void enable_systemasic_irq(unsigned int irq)
 {
-        __u32 emr =3D EMR_BASE + (LEVEL(irq) << 4) + (LEVEL(irq) << 2);
-        __u32 mask;
+	__u32 emr =3D EMR_BASE + (LEVEL(irq) << 4) + (LEVEL(irq) << 2);
+	__u32 mask;
=20
-        mask =3D inl(emr);
-        mask |=3D (1 << EVENT_BIT(irq));
-        outl(mask, emr);
+	mask =3D inl(emr);
+	mask |=3D (1 << EVENT_BIT(irq));
+	outl(mask, emr);
 }
=20
 /* Acknowledge a hardware event by writing its bit back to its ESR */
 static void ack_systemasic_irq(unsigned int irq)
 {
-        __u32 esr =3D ESR_BASE + (LEVEL(irq) << 2);
-        disable_systemasic_irq(irq);
-        outl((1 << EVENT_BIT(irq)), esr);
+	__u32 esr =3D ESR_BASE + (LEVEL(irq) << 2);
+	disable_systemasic_irq(irq);
+	outl((1 << EVENT_BIT(irq)), esr);
 }
=20
 /* After a IRQ has been ack'd and responded to, it needs to be renabled */
 static void end_systemasic_irq(unsigned int irq)
 {
-        if (!(irq_desc[irq].status & (IRQ_DISABLED|IRQ_INPROGRESS)))
-                enable_systemasic_irq(irq);
+	if (!(irq_desc[irq].status & (IRQ_DISABLED|IRQ_INPROGRESS)))
+		enable_systemasic_irq(irq);
 }
=20
 static unsigned int startup_systemasic_irq(unsigned int irq)
 {
-        enable_systemasic_irq(irq);
+	enable_systemasic_irq(irq);
=20
-        return 0;
+	return 0;
 }
=20
 static void shutdown_systemasic_irq(unsigned int irq)
 {
-        disable_systemasic_irq(irq);
+	disable_systemasic_irq(irq);
 }
=20
 struct hw_interrupt_type systemasic_int =3D {
-        .typename       =3D "System ASIC",
-        .startup        =3D startup_systemasic_irq,
-        .shutdown       =3D shutdown_systemasic_irq,
-        .enable         =3D enable_systemasic_irq,
-        .disable        =3D disable_systemasic_irq,
-        .ack            =3D ack_systemasic_irq,
-        .end            =3D end_systemasic_irq,
+	.typename	=3D "System ASIC",
+	.startup	=3D startup_systemasic_irq,
+	.shutdown	=3D shutdown_systemasic_irq,
+	.enable		=3D enable_systemasic_irq,
+	.disable	=3D disable_systemasic_irq,
+	.ack		=3D ack_systemasic_irq,
+	.end		=3D end_systemasic_irq,
 };
=20
 /*
@@ -117,37 +118,37 @@ struct hw_interrupt_type systemasic_int =3D {
  */
 int systemasic_irq_demux(int irq)
 {
-        __u32 emr, esr, status, level;
-        __u32 j, bit;
-
-        switch (irq) {
-                case 13:
-                        level =3D 0;
-                        break;
-                case 11:
-                        level =3D 1;
-                        break;
-                case  9:
-                        level =3D 2;
-                        break;
-                default:
-                        return irq;
-        }
-        emr =3D EMR_BASE + (level << 4) + (level << 2);
-        esr =3D ESR_BASE + (level << 2);
-
-        /* Mask the ESR to filter any spurious, unwanted interrupts */
-        status =3D inl(esr);
-        status &=3D inl(emr);
-
-        /* Now scan and find the first set bit as the event to map */
-        for (bit =3D 1, j =3D 0; j < 32; bit <<=3D 1, j++) {
-                if (status & bit) {
-                        irq =3D HW_EVENT_IRQ_BASE + j + (level << 5);
-                        return irq;
-                }
-        }
-
-        /* Not reached */
-        return irq;
+	__u32 emr, esr, status, level;
+	__u32 j, bit;
+
+	switch (irq) {
+	case 13:
+		level =3D 0;
+		break;
+	case 11:
+		level =3D 1;
+		break;
+	case  9:
+		level =3D 2;
+		break;
+	default:
+		return irq;
+	}
+	emr =3D EMR_BASE + (level << 4) + (level << 2);
+	esr =3D ESR_BASE + (level << 2);
+
+	/* Mask the ESR to filter any spurious, unwanted interrupts */
+	status =3D inl(esr);
+	status &=3D inl(emr);
+
+	/* Now scan and find the first set bit as the event to map */
+	for (bit =3D 1, j =3D 0; j < 32; bit <<=3D 1, j++) {
+		if (status & bit) {
+			irq =3D HW_EVENT_IRQ_BASE + j + (level << 5);
+			return irq;
+		}
+	}
+
+	/* Not reached */
+	return irq;
 }


--=20
Kristoffer Ericson <kristoffer.ericson@gmail.com>

--Multipart=_Tue__18_Nov_2008_17_49_27_+0100_DNHtcQ1DYJ2ktUX9
Content-Type: application/octet-stream;
 name="fix-dreamcast-irq-formatting.patch"
Content-Disposition: attachment;
 filename="fix-dreamcast-irq-formatting.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2FyY2gvc2gvYm9hcmRzL21hY2gtZHJlYW1jYXN0L2lycS5jIGIvYXJjaC9z
aC9ib2FyZHMvbWFjaC1kcmVhbWNhc3QvaXJxLmMKaW5kZXggNjdiZGMzMy4uMzZhOGEwOCAxMDA2
NDQKLS0tIGEvYXJjaC9zaC9ib2FyZHMvbWFjaC1kcmVhbWNhc3QvaXJxLmMKKysrIGIvYXJjaC9z
aC9ib2FyZHMvbWFjaC1kcmVhbWNhc3QvaXJxLmMKQEAgLTE0LDMxICsxNCwzMiBAQAogI2luY2x1
ZGUgPGFzbS9pcnEuaD4KICNpbmNsdWRlIDxtYWNoL3N5c2FzaWMuaD4KIAotLyogRHJlYW1jYXN0
IFN5c3RlbSBBU0lDIEhhcmR3YXJlIEV2ZW50cyAtCi0KLSAgIFRoZSBEcmVhbWNhc3QncyBTeXN0
ZW0gQVNJQyAoYS5rLmEuIEhvbGx5KSBpcyByZXNwb25zaWJsZSBmb3IgcmVjZWl2aW5nCi0gICBo
YXJkd2FyZSBldmVudHMgZnJvbSBzeXN0ZW0gcGVyaXBoZXJhbHMgYW5kIHRyaWdnZXJpbmcgYW4g
U0g3NzUwIElSUS4KLSAgIEhhcmR3YXJlIGV2ZW50cyBjYW4gdHJpZ2dlciBJUlFzIDEzLCAxMSwg
b3IgOSBkZXBlbmRpbmcgb24gd2hpY2ggYml0cyBhcmUKLSAgIHNldCBpbiB0aGUgRXZlbnQgTWFz
ayBSZWdpc3RlcnMgKEVNUnMpLiAgV2hlbiBhIGhhcmR3YXJlIGV2ZW50IGlzCi0gICB0cmlnZ2Vy
ZWQsIGl0J3MgY29ycmVzcG9uZGluZyBiaXQgaW4gdGhlIEV2ZW50IFN0YXR1cyBSZWdpc3RlcnMg
KEVTUnMpCi0gICBpcyBzZXQsIGFuZCB0aGF0IGJpdCBzaG91bGQgYmUgcmV3cml0dGVuIHRvIHRo
ZSBFU1IgdG8gYWNrbm93bGVkZ2UgdGhhdAotICAgZXZlbnQuCi0KLSAgIFRoZXJlIGFyZSB0aHJl
ZSAzMi1iaXQgRVNScyBsb2NhdGVkIGF0IDB4YTA1Zjg5MDAgLSAweGEwNWY2OTA4LiAgRXZlbnQK
LSAgIHR5cGVzIGNhbiBiZSBmb3VuZCBpbiBpbmNsdWRlL2FzbS1zaC9kcmVhbWNhc3Qvc3lzYXNp
Yy5oLiBUaGVyZSBhcmUgdGhyZWUKLSAgIGdyb3VwcyBvZiBFTVJzIHRoYXQgcGFyYWxsZWwgdGhl
IEVTUnMuICBFYWNoIEVNUiBncm91cCBjb3JyZXNwb25kcyB0byBhbgotICAgSVJRLCBzbyAweGEw
NWY2OTEwIC0gMHhhMDVmNjkxOCB0cmlnZ2VycyBJUlEgMTMsIDB4YTA1ZjY5MjAgLSAweGEwNWY2
OTI4Ci0gICB0cmlnZ2VycyBJUlEgMTEsIGFuZCAweGEwNWY2OTMwIC0gMHhhMDVmNjkzOCB0cmln
Z2VycyBJUlEgOS4KLQotICAgSW4gdGhlIGtlcm5lbCwgdGhlc2UgZXZlbnRzIGFyZSBtYXBwZWQg
dG8gdmlydHVhbCBJUlFzIHNvIHRoYXQgZHJpdmVycyBjYW4KLSAgIHJlc3BvbmQgdG8gdGhlbSBh
cyB0aGV5IHdvdWxkIGEgbm9ybWFsIGludGVycnVwdC4gIEluIG9yZGVyIHRvIGtlZXAgdGhpcwot
ICAgbWFwcGluZyBzaW1wbGUsIHRoZSBldmVudHMgYXJlIG1hcHBlZCBhczoKLQotICAgNjkwMC82
OTEwIC0gRXZlbnRzICAwLTMxLCBJUlEgMTMKLSAgIDY5MDQvNjkyNCAtIEV2ZW50cyAzMi02Mywg
SVJRIDExCi0gICA2OTA4LzY5MzggLSBFdmVudHMgNjQtOTUsIElSUSAgOQotCi0qLworLyoKKyAq
IERyZWFtY2FzdCBTeXN0ZW0gQVNJQyBIYXJkd2FyZSBFdmVudHMKKyAqCisgKiBUaGUgRHJlYW1j
YXN0J3MgU3lzdGVtIEFTSUMgKGEuay5hLiBIb2xseSkgaXMgcmVzcG9uc2libGUgZm9yIHJlY2Vp
dmluZworICogaGFyZHdhcmUgZXZlbnRzIGZyb20gc3lzdGVtIHBlcmlwaGVyYWxzIGFuZCB0cmln
Z2VyaW5nIGFuIFNINzc1MCBJUlEuCisgKiBIYXJkd2FyZSBldmVudHMgY2FuIHRyaWdnZXIgSVJR
cyAxMywgMTEsIG9yIDkgZGVwZW5kaW5nIG9uIHdoaWNoIGJpdHMgYXJlCisgKiBzZXQgaW4gdGhl
IEV2ZW50IE1hc2sgUmVnaXN0ZXJzIChFTVJzKS4gIFdoZW4gYSBoYXJkd2FyZSBldmVudCBpcwor
ICogdHJpZ2dlcmVkLCBpdCdzIGNvcnJlc3BvbmRpbmcgYml0IGluIHRoZSBFdmVudCBTdGF0dXMg
UmVnaXN0ZXJzIChFU1JzKQorICogaXMgc2V0LCBhbmQgdGhhdCBiaXQgc2hvdWxkIGJlIHJld3Jp
dHRlbiB0byB0aGUgRVNSIHRvIGFja25vd2xlZGdlIHRoYXQKKyAqIGV2ZW50LgorICoKKyAqIFRo
ZXJlIGFyZSB0aHJlZSAzMi1iaXQgRVNScyBsb2NhdGVkIGF0IDB4YTA1Zjg5MDAgLSAweGEwNWY2
OTA4LiAgRXZlbnQKKyAqIHR5cGVzIGNhbiBiZSBmb3VuZCBpbiBpbmNsdWRlL2FzbS1zaC9kcmVh
bWNhc3Qvc3lzYXNpYy5oLiBUaGVyZSBhcmUgdGhyZWUKKyAqIGdyb3VwcyBvZiBFTVJzIHRoYXQg
cGFyYWxsZWwgdGhlIEVTUnMuICBFYWNoIEVNUiBncm91cCBjb3JyZXNwb25kcyB0byBhbgorICog
SVJRLCBzbyAweGEwNWY2OTEwIC0gMHhhMDVmNjkxOCB0cmlnZ2VycyBJUlEgMTMsIDB4YTA1ZjY5
MjAgLSAweGEwNWY2OTI4CisgKiB0cmlnZ2VycyBJUlEgMTEsIGFuZCAweGEwNWY2OTMwIC0gMHhh
MDVmNjkzOCB0cmlnZ2VycyBJUlEgOS4KKyAqCisgKiBJbiB0aGUga2VybmVsLCB0aGVzZSBldmVu
dHMgYXJlIG1hcHBlZCB0byB2aXJ0dWFsIElSUXMgc28gdGhhdCBkcml2ZXJzIGNhbgorICogcmVz
cG9uZCB0byB0aGVtIGFzIHRoZXkgd291bGQgYSBub3JtYWwgaW50ZXJydXB0LiAgSW4gb3JkZXIg
dG8ga2VlcCB0aGlzCisgKiBtYXBwaW5nIHNpbXBsZSwgdGhlIGV2ZW50cyBhcmUgbWFwcGVkIGFz
OgorICoKKyAqIDY5MDAvNjkxMCAtIEV2ZW50cyAgMC0zMSwgSVJRIDEzCisgKiA2OTA0LzY5MjQg
LSBFdmVudHMgMzItNjMsIElSUSAxMQorICogNjkwOC82OTM4IC0gRXZlbnRzIDY0LTk1LCBJUlEg
IDkKKyAqCisgKi8KIAogI2RlZmluZSBFU1JfQkFTRSAweDAwNWY2OTAwICAgIC8qIEJhc2UgZXZl
bnQgc3RhdHVzIHJlZ2lzdGVyICovCiAjZGVmaW5lIEVNUl9CQVNFIDB4MDA1ZjY5MTAgICAgLyog
QmFzZSBldmVudCBtYXNrIHJlZ2lzdGVyICovCkBAIC01Niw2MCArNTcsNjAgQEAKIC8qIERpc2Fi
bGUgdGhlIGhhcmR3YXJlIGV2ZW50IGJ5IG1hc2tpbmcgaXRzIGJpdCBpbiBpdHMgRU1SICovCiBz
dGF0aWMgaW5saW5lIHZvaWQgZGlzYWJsZV9zeXN0ZW1hc2ljX2lycSh1bnNpZ25lZCBpbnQgaXJx
KQogewotICAgICAgICBfX3UzMiBlbXIgPSBFTVJfQkFTRSArIChMRVZFTChpcnEpIDw8IDQpICsg
KExFVkVMKGlycSkgPDwgMik7Ci0gICAgICAgIF9fdTMyIG1hc2s7CisJX191MzIgZW1yID0gRU1S
X0JBU0UgKyAoTEVWRUwoaXJxKSA8PCA0KSArIChMRVZFTChpcnEpIDw8IDIpOworCV9fdTMyIG1h
c2s7CiAKLSAgICAgICAgbWFzayA9IGlubChlbXIpOwotICAgICAgICBtYXNrICY9IH4oMSA8PCBF
VkVOVF9CSVQoaXJxKSk7Ci0gICAgICAgIG91dGwobWFzaywgZW1yKTsKKwltYXNrID0gaW5sKGVt
cik7CisJbWFzayAmPSB+KDEgPDwgRVZFTlRfQklUKGlycSkpOworCW91dGwobWFzaywgZW1yKTsK
IH0KIAogLyogRW5hYmxlIHRoZSBoYXJkd2FyZSBldmVudCBieSBzZXR0aW5nIGl0cyBiaXQgaW4g
aXRzIEVNUiAqLwogc3RhdGljIGlubGluZSB2b2lkIGVuYWJsZV9zeXN0ZW1hc2ljX2lycSh1bnNp
Z25lZCBpbnQgaXJxKQogewotICAgICAgICBfX3UzMiBlbXIgPSBFTVJfQkFTRSArIChMRVZFTChp
cnEpIDw8IDQpICsgKExFVkVMKGlycSkgPDwgMik7Ci0gICAgICAgIF9fdTMyIG1hc2s7CisJX191
MzIgZW1yID0gRU1SX0JBU0UgKyAoTEVWRUwoaXJxKSA8PCA0KSArIChMRVZFTChpcnEpIDw8IDIp
OworCV9fdTMyIG1hc2s7CiAKLSAgICAgICAgbWFzayA9IGlubChlbXIpOwotICAgICAgICBtYXNr
IHw9ICgxIDw8IEVWRU5UX0JJVChpcnEpKTsKLSAgICAgICAgb3V0bChtYXNrLCBlbXIpOworCW1h
c2sgPSBpbmwoZW1yKTsKKwltYXNrIHw9ICgxIDw8IEVWRU5UX0JJVChpcnEpKTsKKwlvdXRsKG1h
c2ssIGVtcik7CiB9CiAKIC8qIEFja25vd2xlZGdlIGEgaGFyZHdhcmUgZXZlbnQgYnkgd3JpdGlu
ZyBpdHMgYml0IGJhY2sgdG8gaXRzIEVTUiAqLwogc3RhdGljIHZvaWQgYWNrX3N5c3RlbWFzaWNf
aXJxKHVuc2lnbmVkIGludCBpcnEpCiB7Ci0gICAgICAgIF9fdTMyIGVzciA9IEVTUl9CQVNFICsg
KExFVkVMKGlycSkgPDwgMik7Ci0gICAgICAgIGRpc2FibGVfc3lzdGVtYXNpY19pcnEoaXJxKTsK
LSAgICAgICAgb3V0bCgoMSA8PCBFVkVOVF9CSVQoaXJxKSksIGVzcik7CisJX191MzIgZXNyID0g
RVNSX0JBU0UgKyAoTEVWRUwoaXJxKSA8PCAyKTsKKwlkaXNhYmxlX3N5c3RlbWFzaWNfaXJxKGly
cSk7CisJb3V0bCgoMSA8PCBFVkVOVF9CSVQoaXJxKSksIGVzcik7CiB9CiAKIC8qIEFmdGVyIGEg
SVJRIGhhcyBiZWVuIGFjaydkIGFuZCByZXNwb25kZWQgdG8sIGl0IG5lZWRzIHRvIGJlIHJlbmFi
bGVkICovCiBzdGF0aWMgdm9pZCBlbmRfc3lzdGVtYXNpY19pcnEodW5zaWduZWQgaW50IGlycSkK
IHsKLSAgICAgICAgaWYgKCEoaXJxX2Rlc2NbaXJxXS5zdGF0dXMgJiAoSVJRX0RJU0FCTEVEfElS
UV9JTlBST0dSRVNTKSkpCi0gICAgICAgICAgICAgICAgZW5hYmxlX3N5c3RlbWFzaWNfaXJxKGly
cSk7CisJaWYgKCEoaXJxX2Rlc2NbaXJxXS5zdGF0dXMgJiAoSVJRX0RJU0FCTEVEfElSUV9JTlBS
T0dSRVNTKSkpCisJCWVuYWJsZV9zeXN0ZW1hc2ljX2lycShpcnEpOwogfQogCiBzdGF0aWMgdW5z
aWduZWQgaW50IHN0YXJ0dXBfc3lzdGVtYXNpY19pcnEodW5zaWduZWQgaW50IGlycSkKIHsKLSAg
ICAgICAgZW5hYmxlX3N5c3RlbWFzaWNfaXJxKGlycSk7CisJZW5hYmxlX3N5c3RlbWFzaWNfaXJx
KGlycSk7CiAKLSAgICAgICAgcmV0dXJuIDA7CisJcmV0dXJuIDA7CiB9CiAKIHN0YXRpYyB2b2lk
IHNodXRkb3duX3N5c3RlbWFzaWNfaXJxKHVuc2lnbmVkIGludCBpcnEpCiB7Ci0gICAgICAgIGRp
c2FibGVfc3lzdGVtYXNpY19pcnEoaXJxKTsKKwlkaXNhYmxlX3N5c3RlbWFzaWNfaXJxKGlycSk7
CiB9CiAKIHN0cnVjdCBod19pbnRlcnJ1cHRfdHlwZSBzeXN0ZW1hc2ljX2ludCA9IHsKLSAgICAg
ICAgLnR5cGVuYW1lICAgICAgID0gIlN5c3RlbSBBU0lDIiwKLSAgICAgICAgLnN0YXJ0dXAgICAg
ICAgID0gc3RhcnR1cF9zeXN0ZW1hc2ljX2lycSwKLSAgICAgICAgLnNodXRkb3duICAgICAgID0g
c2h1dGRvd25fc3lzdGVtYXNpY19pcnEsCi0gICAgICAgIC5lbmFibGUgICAgICAgICA9IGVuYWJs
ZV9zeXN0ZW1hc2ljX2lycSwKLSAgICAgICAgLmRpc2FibGUgICAgICAgID0gZGlzYWJsZV9zeXN0
ZW1hc2ljX2lycSwKLSAgICAgICAgLmFjayAgICAgICAgICAgID0gYWNrX3N5c3RlbWFzaWNfaXJx
LAotICAgICAgICAuZW5kICAgICAgICAgICAgPSBlbmRfc3lzdGVtYXNpY19pcnEsCisJLnR5cGVu
YW1lCT0gIlN5c3RlbSBBU0lDIiwKKwkuc3RhcnR1cAk9IHN0YXJ0dXBfc3lzdGVtYXNpY19pcnEs
CisJLnNodXRkb3duCT0gc2h1dGRvd25fc3lzdGVtYXNpY19pcnEsCisJLmVuYWJsZQkJPSBlbmFi
bGVfc3lzdGVtYXNpY19pcnEsCisJLmRpc2FibGUJPSBkaXNhYmxlX3N5c3RlbWFzaWNfaXJxLAor
CS5hY2sJCT0gYWNrX3N5c3RlbWFzaWNfaXJxLAorCS5lbmQJCT0gZW5kX3N5c3RlbWFzaWNfaXJx
LAogfTsKIAogLyoKQEAgLTExNywzNyArMTE4LDM3IEBAIHN0cnVjdCBod19pbnRlcnJ1cHRfdHlw
ZSBzeXN0ZW1hc2ljX2ludCA9IHsKICAqLwogaW50IHN5c3RlbWFzaWNfaXJxX2RlbXV4KGludCBp
cnEpCiB7Ci0gICAgICAgIF9fdTMyIGVtciwgZXNyLCBzdGF0dXMsIGxldmVsOwotICAgICAgICBf
X3UzMiBqLCBiaXQ7Ci0KLSAgICAgICAgc3dpdGNoIChpcnEpIHsKLSAgICAgICAgICAgICAgICBj
YXNlIDEzOgotICAgICAgICAgICAgICAgICAgICAgICAgbGV2ZWwgPSAwOwotICAgICAgICAgICAg
ICAgICAgICAgICAgYnJlYWs7Ci0gICAgICAgICAgICAgICAgY2FzZSAxMToKLSAgICAgICAgICAg
ICAgICAgICAgICAgIGxldmVsID0gMTsKLSAgICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOwot
ICAgICAgICAgICAgICAgIGNhc2UgIDk6Ci0gICAgICAgICAgICAgICAgICAgICAgICBsZXZlbCA9
IDI7Ci0gICAgICAgICAgICAgICAgICAgICAgICBicmVhazsKLSAgICAgICAgICAgICAgICBkZWZh
dWx0OgotICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIGlycTsKLSAgICAgICAgfQotICAg
ICAgICBlbXIgPSBFTVJfQkFTRSArIChsZXZlbCA8PCA0KSArIChsZXZlbCA8PCAyKTsKLSAgICAg
ICAgZXNyID0gRVNSX0JBU0UgKyAobGV2ZWwgPDwgMik7Ci0KLSAgICAgICAgLyogTWFzayB0aGUg
RVNSIHRvIGZpbHRlciBhbnkgc3B1cmlvdXMsIHVud2FudGVkIGludGVycnVwdHMgKi8KLSAgICAg
ICAgc3RhdHVzID0gaW5sKGVzcik7Ci0gICAgICAgIHN0YXR1cyAmPSBpbmwoZW1yKTsKLQotICAg
ICAgICAvKiBOb3cgc2NhbiBhbmQgZmluZCB0aGUgZmlyc3Qgc2V0IGJpdCBhcyB0aGUgZXZlbnQg
dG8gbWFwICovCi0gICAgICAgIGZvciAoYml0ID0gMSwgaiA9IDA7IGogPCAzMjsgYml0IDw8PSAx
LCBqKyspIHsKLSAgICAgICAgICAgICAgICBpZiAoc3RhdHVzICYgYml0KSB7Ci0gICAgICAgICAg
ICAgICAgICAgICAgICBpcnEgPSBIV19FVkVOVF9JUlFfQkFTRSArIGogKyAobGV2ZWwgPDwgNSk7
Ci0gICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gaXJxOwotICAgICAgICAgICAgICAgIH0K
LSAgICAgICAgfQotCi0gICAgICAgIC8qIE5vdCByZWFjaGVkICovCi0gICAgICAgIHJldHVybiBp
cnE7CisJX191MzIgZW1yLCBlc3IsIHN0YXR1cywgbGV2ZWw7CisJX191MzIgaiwgYml0OworCisJ
c3dpdGNoIChpcnEpIHsKKwljYXNlIDEzOgorCQlsZXZlbCA9IDA7CisJCWJyZWFrOworCWNhc2Ug
MTE6CisJCWxldmVsID0gMTsKKwkJYnJlYWs7CisJY2FzZSAgOToKKwkJbGV2ZWwgPSAyOworCQli
cmVhazsKKwlkZWZhdWx0OgorCQlyZXR1cm4gaXJxOworCX0KKwllbXIgPSBFTVJfQkFTRSArIChs
ZXZlbCA8PCA0KSArIChsZXZlbCA8PCAyKTsKKwllc3IgPSBFU1JfQkFTRSArIChsZXZlbCA8PCAy
KTsKKworCS8qIE1hc2sgdGhlIEVTUiB0byBmaWx0ZXIgYW55IHNwdXJpb3VzLCB1bndhbnRlZCBp
bnRlcnJ1cHRzICovCisJc3RhdHVzID0gaW5sKGVzcik7CisJc3RhdHVzICY9IGlubChlbXIpOwor
CisJLyogTm93IHNjYW4gYW5kIGZpbmQgdGhlIGZpcnN0IHNldCBiaXQgYXMgdGhlIGV2ZW50IHRv
IG1hcCAqLworCWZvciAoYml0ID0gMSwgaiA9IDA7IGogPCAzMjsgYml0IDw8PSAxLCBqKyspIHsK
KwkJaWYgKHN0YXR1cyAmIGJpdCkgeworCQkJaXJxID0gSFdfRVZFTlRfSVJRX0JBU0UgKyBqICsg
KGxldmVsIDw8IDUpOworCQkJcmV0dXJuIGlycTsKKwkJfQorCX0KKworCS8qIE5vdCByZWFjaGVk
ICovCisJcmV0dXJuIGlycTsKIH0K

--Multipart=_Tue__18_Nov_2008_17_49_27_+0100_DNHtcQ1DYJ2ktUX9--

--Signature=_Tue__18_Nov_2008_17_49_27_+0100_zdCEftDb.gKHeAe7
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkki8hcACgkQPQls10ERAGeLRwCfZoWj4rof5vhPfmAs4OoIr6PZ
YAQAn088Pj5Jh63crCiTs6KlDoZdcCiE
=MAJR
-----END PGP SIGNATURE-----

--Signature=_Tue__18_Nov_2008_17_49_27_+0100_zdCEftDb.gKHeAe7--
