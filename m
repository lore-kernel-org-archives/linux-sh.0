From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Date: Tue, 18 Nov 2008 15:28:15 +0000
Subject: [PATCH] - Fix dreamcast irq.c formatting
Message-Id: <20081118172847.1ac04194.kristoffer.ericson@gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Signature=_Tue__18_Nov_2008_17_28_47_+0100_0tzx9si6iJ3hMTNJ"
List-Id: <linux-sh.vger.kernel.org>
To: linux-sh@vger.kernel.org

--Signature=_Tue__18_Nov_2008_17_28_47_+0100_0tzx9si6iJ3hMTNJ
Content-Type: multipart/mixed;
 boundary="Multipart=_Tue__18_Nov_2008_17_28_47_+0100_RsI=YOatyJNQrKev"


--Multipart=_Tue__18_Nov_2008_17_28_47_+0100_RsI=YOatyJNQrKev
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This patch cleans the bad formatting
found in mach-dreamcast/irq.c file.

Signed-off-by: Kristoffer Ericson <Kristoffer.Ericson@gmail.com>

diff --git a/arch/sh/boards/mach-dreamcast/irq.c b/arch/sh/boards/mach-drea=
mcast/irq.c
index 67bdc33..482a382 100644
--- a/arch/sh/boards/mach-dreamcast/irq.c
+++ b/arch/sh/boards/mach-dreamcast/irq.c
@@ -16,27 +16,27 @@
=20
 /* Dreamcast System ASIC Hardware Events -
=20
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
+ The Dreamcast's System ASIC (a.k.a. Holly) is responsible for receiving
+ hardware events from system peripherals and triggering an SH7750 IRQ.
+ Hardware events can trigger IRQs 13, 11, or 9 depending on which bits are
+ set in the Event Mask Registers (EMRs).  When a hardware event is
+ triggered, it's corresponding bit in the Event Status Registers (ESRs)
+ is set, and that bit should be rewritten to the ESR to acknowledge that
+ event.
+
+ There are three 32-bit ESRs located at 0xa05f8900 - 0xa05f6908.  Event
+ types can be found in include/asm-sh/dreamcast/sysasic.h. There are three
+ groups of EMRs that parallel the ESRs.  Each EMR group corresponds to an
+ IRQ, so 0xa05f6910 - 0xa05f6918 triggers IRQ 13, 0xa05f6920 - 0xa05f6928
+ triggers IRQ 11, and 0xa05f6930 - 0xa05f6938 triggers IRQ 9.
+
+ In the kernel, these events are mapped to virtual IRQs so that drivers can
+ respond to them as they would a normal interrupt.  In order to keep this
+ mapping simple, the events are mapped as:
+
+ 6900/6910 - Events  0-31, IRQ 13
+ 6904/6924 - Events 32-63, IRQ 11
+ 6908/6938 - Events 64-95, IRQ  9
=20
 */
=20
@@ -56,60 +56,60 @@
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
@@ -117,37 +117,37 @@ struct hw_interrupt_type systemasic_int =3D {
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
+		case 13:
+			level =3D 0;
+			break;
+		case 11:
+			level =3D 1;
+			break;
+		case  9:
+			level =3D 2;
+			break;
+		default:
+			return irq;
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

--Multipart=_Tue__18_Nov_2008_17_28_47_+0100_RsI=YOatyJNQrKev
Content-Type: application/octet-stream;
 name="fix-dreamcast-irq-formatting.patch"
Content-Disposition: attachment;
 filename="fix-dreamcast-irq-formatting.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2FyY2gvc2gvYm9hcmRzL21hY2gtZHJlYW1jYXN0L2lycS5jIGIvYXJjaC9z
aC9ib2FyZHMvbWFjaC1kcmVhbWNhc3QvaXJxLmMKaW5kZXggNjdiZGMzMy4uNDgyYTM4MiAxMDA2
NDQKLS0tIGEvYXJjaC9zaC9ib2FyZHMvbWFjaC1kcmVhbWNhc3QvaXJxLmMKKysrIGIvYXJjaC9z
aC9ib2FyZHMvbWFjaC1kcmVhbWNhc3QvaXJxLmMKQEAgLTE2LDI3ICsxNiwyNyBAQAogCiAvKiBE
cmVhbWNhc3QgU3lzdGVtIEFTSUMgSGFyZHdhcmUgRXZlbnRzIC0KIAotICAgVGhlIERyZWFtY2Fz
dCdzIFN5c3RlbSBBU0lDIChhLmsuYS4gSG9sbHkpIGlzIHJlc3BvbnNpYmxlIGZvciByZWNlaXZp
bmcKLSAgIGhhcmR3YXJlIGV2ZW50cyBmcm9tIHN5c3RlbSBwZXJpcGhlcmFscyBhbmQgdHJpZ2dl
cmluZyBhbiBTSDc3NTAgSVJRLgotICAgSGFyZHdhcmUgZXZlbnRzIGNhbiB0cmlnZ2VyIElSUXMg
MTMsIDExLCBvciA5IGRlcGVuZGluZyBvbiB3aGljaCBiaXRzIGFyZQotICAgc2V0IGluIHRoZSBF
dmVudCBNYXNrIFJlZ2lzdGVycyAoRU1ScykuICBXaGVuIGEgaGFyZHdhcmUgZXZlbnQgaXMKLSAg
IHRyaWdnZXJlZCwgaXQncyBjb3JyZXNwb25kaW5nIGJpdCBpbiB0aGUgRXZlbnQgU3RhdHVzIFJl
Z2lzdGVycyAoRVNScykKLSAgIGlzIHNldCwgYW5kIHRoYXQgYml0IHNob3VsZCBiZSByZXdyaXR0
ZW4gdG8gdGhlIEVTUiB0byBhY2tub3dsZWRnZSB0aGF0Ci0gICBldmVudC4KLQotICAgVGhlcmUg
YXJlIHRocmVlIDMyLWJpdCBFU1JzIGxvY2F0ZWQgYXQgMHhhMDVmODkwMCAtIDB4YTA1ZjY5MDgu
ICBFdmVudAotICAgdHlwZXMgY2FuIGJlIGZvdW5kIGluIGluY2x1ZGUvYXNtLXNoL2RyZWFtY2Fz
dC9zeXNhc2ljLmguIFRoZXJlIGFyZSB0aHJlZQotICAgZ3JvdXBzIG9mIEVNUnMgdGhhdCBwYXJh
bGxlbCB0aGUgRVNScy4gIEVhY2ggRU1SIGdyb3VwIGNvcnJlc3BvbmRzIHRvIGFuCi0gICBJUlEs
IHNvIDB4YTA1ZjY5MTAgLSAweGEwNWY2OTE4IHRyaWdnZXJzIElSUSAxMywgMHhhMDVmNjkyMCAt
IDB4YTA1ZjY5MjgKLSAgIHRyaWdnZXJzIElSUSAxMSwgYW5kIDB4YTA1ZjY5MzAgLSAweGEwNWY2
OTM4IHRyaWdnZXJzIElSUSA5LgotCi0gICBJbiB0aGUga2VybmVsLCB0aGVzZSBldmVudHMgYXJl
IG1hcHBlZCB0byB2aXJ0dWFsIElSUXMgc28gdGhhdCBkcml2ZXJzIGNhbgotICAgcmVzcG9uZCB0
byB0aGVtIGFzIHRoZXkgd291bGQgYSBub3JtYWwgaW50ZXJydXB0LiAgSW4gb3JkZXIgdG8ga2Vl
cCB0aGlzCi0gICBtYXBwaW5nIHNpbXBsZSwgdGhlIGV2ZW50cyBhcmUgbWFwcGVkIGFzOgotCi0g
ICA2OTAwLzY5MTAgLSBFdmVudHMgIDAtMzEsIElSUSAxMwotICAgNjkwNC82OTI0IC0gRXZlbnRz
IDMyLTYzLCBJUlEgMTEKLSAgIDY5MDgvNjkzOCAtIEV2ZW50cyA2NC05NSwgSVJRICA5CisgVGhl
IERyZWFtY2FzdCdzIFN5c3RlbSBBU0lDIChhLmsuYS4gSG9sbHkpIGlzIHJlc3BvbnNpYmxlIGZv
ciByZWNlaXZpbmcKKyBoYXJkd2FyZSBldmVudHMgZnJvbSBzeXN0ZW0gcGVyaXBoZXJhbHMgYW5k
IHRyaWdnZXJpbmcgYW4gU0g3NzUwIElSUS4KKyBIYXJkd2FyZSBldmVudHMgY2FuIHRyaWdnZXIg
SVJRcyAxMywgMTEsIG9yIDkgZGVwZW5kaW5nIG9uIHdoaWNoIGJpdHMgYXJlCisgc2V0IGluIHRo
ZSBFdmVudCBNYXNrIFJlZ2lzdGVycyAoRU1ScykuICBXaGVuIGEgaGFyZHdhcmUgZXZlbnQgaXMK
KyB0cmlnZ2VyZWQsIGl0J3MgY29ycmVzcG9uZGluZyBiaXQgaW4gdGhlIEV2ZW50IFN0YXR1cyBS
ZWdpc3RlcnMgKEVTUnMpCisgaXMgc2V0LCBhbmQgdGhhdCBiaXQgc2hvdWxkIGJlIHJld3JpdHRl
biB0byB0aGUgRVNSIHRvIGFja25vd2xlZGdlIHRoYXQKKyBldmVudC4KKworIFRoZXJlIGFyZSB0
aHJlZSAzMi1iaXQgRVNScyBsb2NhdGVkIGF0IDB4YTA1Zjg5MDAgLSAweGEwNWY2OTA4LiAgRXZl
bnQKKyB0eXBlcyBjYW4gYmUgZm91bmQgaW4gaW5jbHVkZS9hc20tc2gvZHJlYW1jYXN0L3N5c2Fz
aWMuaC4gVGhlcmUgYXJlIHRocmVlCisgZ3JvdXBzIG9mIEVNUnMgdGhhdCBwYXJhbGxlbCB0aGUg
RVNScy4gIEVhY2ggRU1SIGdyb3VwIGNvcnJlc3BvbmRzIHRvIGFuCisgSVJRLCBzbyAweGEwNWY2
OTEwIC0gMHhhMDVmNjkxOCB0cmlnZ2VycyBJUlEgMTMsIDB4YTA1ZjY5MjAgLSAweGEwNWY2OTI4
CisgdHJpZ2dlcnMgSVJRIDExLCBhbmQgMHhhMDVmNjkzMCAtIDB4YTA1ZjY5MzggdHJpZ2dlcnMg
SVJRIDkuCisKKyBJbiB0aGUga2VybmVsLCB0aGVzZSBldmVudHMgYXJlIG1hcHBlZCB0byB2aXJ0
dWFsIElSUXMgc28gdGhhdCBkcml2ZXJzIGNhbgorIHJlc3BvbmQgdG8gdGhlbSBhcyB0aGV5IHdv
dWxkIGEgbm9ybWFsIGludGVycnVwdC4gIEluIG9yZGVyIHRvIGtlZXAgdGhpcworIG1hcHBpbmcg
c2ltcGxlLCB0aGUgZXZlbnRzIGFyZSBtYXBwZWQgYXM6CisKKyA2OTAwLzY5MTAgLSBFdmVudHMg
IDAtMzEsIElSUSAxMworIDY5MDQvNjkyNCAtIEV2ZW50cyAzMi02MywgSVJRIDExCisgNjkwOC82
OTM4IC0gRXZlbnRzIDY0LTk1LCBJUlEgIDkKIAogKi8KIApAQCAtNTYsNjAgKzU2LDYwIEBACiAv
KiBEaXNhYmxlIHRoZSBoYXJkd2FyZSBldmVudCBieSBtYXNraW5nIGl0cyBiaXQgaW4gaXRzIEVN
UiAqLwogc3RhdGljIGlubGluZSB2b2lkIGRpc2FibGVfc3lzdGVtYXNpY19pcnEodW5zaWduZWQg
aW50IGlycSkKIHsKLSAgICAgICAgX191MzIgZW1yID0gRU1SX0JBU0UgKyAoTEVWRUwoaXJxKSA8
PCA0KSArIChMRVZFTChpcnEpIDw8IDIpOwotICAgICAgICBfX3UzMiBtYXNrOworCV9fdTMyIGVt
ciA9IEVNUl9CQVNFICsgKExFVkVMKGlycSkgPDwgNCkgKyAoTEVWRUwoaXJxKSA8PCAyKTsKKwlf
X3UzMiBtYXNrOwogCi0gICAgICAgIG1hc2sgPSBpbmwoZW1yKTsKLSAgICAgICAgbWFzayAmPSB+
KDEgPDwgRVZFTlRfQklUKGlycSkpOwotICAgICAgICBvdXRsKG1hc2ssIGVtcik7CisJbWFzayA9
IGlubChlbXIpOworCW1hc2sgJj0gfigxIDw8IEVWRU5UX0JJVChpcnEpKTsKKwlvdXRsKG1hc2ss
IGVtcik7CiB9CiAKIC8qIEVuYWJsZSB0aGUgaGFyZHdhcmUgZXZlbnQgYnkgc2V0dGluZyBpdHMg
Yml0IGluIGl0cyBFTVIgKi8KIHN0YXRpYyBpbmxpbmUgdm9pZCBlbmFibGVfc3lzdGVtYXNpY19p
cnEodW5zaWduZWQgaW50IGlycSkKIHsKLSAgICAgICAgX191MzIgZW1yID0gRU1SX0JBU0UgKyAo
TEVWRUwoaXJxKSA8PCA0KSArIChMRVZFTChpcnEpIDw8IDIpOwotICAgICAgICBfX3UzMiBtYXNr
OworCV9fdTMyIGVtciA9IEVNUl9CQVNFICsgKExFVkVMKGlycSkgPDwgNCkgKyAoTEVWRUwoaXJx
KSA8PCAyKTsKKwlfX3UzMiBtYXNrOwogCi0gICAgICAgIG1hc2sgPSBpbmwoZW1yKTsKLSAgICAg
ICAgbWFzayB8PSAoMSA8PCBFVkVOVF9CSVQoaXJxKSk7Ci0gICAgICAgIG91dGwobWFzaywgZW1y
KTsKKwltYXNrID0gaW5sKGVtcik7CisJbWFzayB8PSAoMSA8PCBFVkVOVF9CSVQoaXJxKSk7CisJ
b3V0bChtYXNrLCBlbXIpOwogfQogCiAvKiBBY2tub3dsZWRnZSBhIGhhcmR3YXJlIGV2ZW50IGJ5
IHdyaXRpbmcgaXRzIGJpdCBiYWNrIHRvIGl0cyBFU1IgKi8KIHN0YXRpYyB2b2lkIGFja19zeXN0
ZW1hc2ljX2lycSh1bnNpZ25lZCBpbnQgaXJxKQogewotICAgICAgICBfX3UzMiBlc3IgPSBFU1Jf
QkFTRSArIChMRVZFTChpcnEpIDw8IDIpOwotICAgICAgICBkaXNhYmxlX3N5c3RlbWFzaWNfaXJx
KGlycSk7Ci0gICAgICAgIG91dGwoKDEgPDwgRVZFTlRfQklUKGlycSkpLCBlc3IpOworCV9fdTMy
IGVzciA9IEVTUl9CQVNFICsgKExFVkVMKGlycSkgPDwgMik7CisJZGlzYWJsZV9zeXN0ZW1hc2lj
X2lycShpcnEpOworCW91dGwoKDEgPDwgRVZFTlRfQklUKGlycSkpLCBlc3IpOwogfQogCiAvKiBB
ZnRlciBhIElSUSBoYXMgYmVlbiBhY2snZCBhbmQgcmVzcG9uZGVkIHRvLCBpdCBuZWVkcyB0byBi
ZSByZW5hYmxlZCAqLwogc3RhdGljIHZvaWQgZW5kX3N5c3RlbWFzaWNfaXJxKHVuc2lnbmVkIGlu
dCBpcnEpCiB7Ci0gICAgICAgIGlmICghKGlycV9kZXNjW2lycV0uc3RhdHVzICYgKElSUV9ESVNB
QkxFRHxJUlFfSU5QUk9HUkVTUykpKQotICAgICAgICAgICAgICAgIGVuYWJsZV9zeXN0ZW1hc2lj
X2lycShpcnEpOworCWlmICghKGlycV9kZXNjW2lycV0uc3RhdHVzICYgKElSUV9ESVNBQkxFRHxJ
UlFfSU5QUk9HUkVTUykpKQorCQllbmFibGVfc3lzdGVtYXNpY19pcnEoaXJxKTsKIH0KIAogc3Rh
dGljIHVuc2lnbmVkIGludCBzdGFydHVwX3N5c3RlbWFzaWNfaXJxKHVuc2lnbmVkIGludCBpcnEp
CiB7Ci0gICAgICAgIGVuYWJsZV9zeXN0ZW1hc2ljX2lycShpcnEpOworCWVuYWJsZV9zeXN0ZW1h
c2ljX2lycShpcnEpOwogCi0gICAgICAgIHJldHVybiAwOworCXJldHVybiAwOwogfQogCiBzdGF0
aWMgdm9pZCBzaHV0ZG93bl9zeXN0ZW1hc2ljX2lycSh1bnNpZ25lZCBpbnQgaXJxKQogewotICAg
ICAgICBkaXNhYmxlX3N5c3RlbWFzaWNfaXJxKGlycSk7CisJZGlzYWJsZV9zeXN0ZW1hc2ljX2ly
cShpcnEpOwogfQogCiBzdHJ1Y3QgaHdfaW50ZXJydXB0X3R5cGUgc3lzdGVtYXNpY19pbnQgPSB7
Ci0gICAgICAgIC50eXBlbmFtZSAgICAgICA9ICJTeXN0ZW0gQVNJQyIsCi0gICAgICAgIC5zdGFy
dHVwICAgICAgICA9IHN0YXJ0dXBfc3lzdGVtYXNpY19pcnEsCi0gICAgICAgIC5zaHV0ZG93biAg
ICAgICA9IHNodXRkb3duX3N5c3RlbWFzaWNfaXJxLAotICAgICAgICAuZW5hYmxlICAgICAgICAg
PSBlbmFibGVfc3lzdGVtYXNpY19pcnEsCi0gICAgICAgIC5kaXNhYmxlICAgICAgICA9IGRpc2Fi
bGVfc3lzdGVtYXNpY19pcnEsCi0gICAgICAgIC5hY2sgICAgICAgICAgICA9IGFja19zeXN0ZW1h
c2ljX2lycSwKLSAgICAgICAgLmVuZCAgICAgICAgICAgID0gZW5kX3N5c3RlbWFzaWNfaXJxLAor
CS50eXBlbmFtZQk9ICJTeXN0ZW0gQVNJQyIsCisJLnN0YXJ0dXAJPSBzdGFydHVwX3N5c3RlbWFz
aWNfaXJxLAorCS5zaHV0ZG93bgk9IHNodXRkb3duX3N5c3RlbWFzaWNfaXJxLAorCS5lbmFibGUJ
CT0gZW5hYmxlX3N5c3RlbWFzaWNfaXJxLAorCS5kaXNhYmxlCT0gZGlzYWJsZV9zeXN0ZW1hc2lj
X2lycSwKKwkuYWNrCQk9IGFja19zeXN0ZW1hc2ljX2lycSwKKwkuZW5kCQk9IGVuZF9zeXN0ZW1h
c2ljX2lycSwKIH07CiAKIC8qCkBAIC0xMTcsMzcgKzExNywzNyBAQCBzdHJ1Y3QgaHdfaW50ZXJy
dXB0X3R5cGUgc3lzdGVtYXNpY19pbnQgPSB7CiAgKi8KIGludCBzeXN0ZW1hc2ljX2lycV9kZW11
eChpbnQgaXJxKQogewotICAgICAgICBfX3UzMiBlbXIsIGVzciwgc3RhdHVzLCBsZXZlbDsKLSAg
ICAgICAgX191MzIgaiwgYml0OwotCi0gICAgICAgIHN3aXRjaCAoaXJxKSB7Ci0gICAgICAgICAg
ICAgICAgY2FzZSAxMzoKLSAgICAgICAgICAgICAgICAgICAgICAgIGxldmVsID0gMDsKLSAgICAg
ICAgICAgICAgICAgICAgICAgIGJyZWFrOwotICAgICAgICAgICAgICAgIGNhc2UgMTE6Ci0gICAg
ICAgICAgICAgICAgICAgICAgICBsZXZlbCA9IDE7Ci0gICAgICAgICAgICAgICAgICAgICAgICBi
cmVhazsKLSAgICAgICAgICAgICAgICBjYXNlICA5OgotICAgICAgICAgICAgICAgICAgICAgICAg
bGV2ZWwgPSAyOwotICAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7Ci0gICAgICAgICAgICAg
ICAgZGVmYXVsdDoKLSAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiBpcnE7Ci0gICAgICAg
IH0KLSAgICAgICAgZW1yID0gRU1SX0JBU0UgKyAobGV2ZWwgPDwgNCkgKyAobGV2ZWwgPDwgMik7
Ci0gICAgICAgIGVzciA9IEVTUl9CQVNFICsgKGxldmVsIDw8IDIpOwotCi0gICAgICAgIC8qIE1h
c2sgdGhlIEVTUiB0byBmaWx0ZXIgYW55IHNwdXJpb3VzLCB1bndhbnRlZCBpbnRlcnJ1cHRzICov
Ci0gICAgICAgIHN0YXR1cyA9IGlubChlc3IpOwotICAgICAgICBzdGF0dXMgJj0gaW5sKGVtcik7
Ci0KLSAgICAgICAgLyogTm93IHNjYW4gYW5kIGZpbmQgdGhlIGZpcnN0IHNldCBiaXQgYXMgdGhl
IGV2ZW50IHRvIG1hcCAqLwotICAgICAgICBmb3IgKGJpdCA9IDEsIGogPSAwOyBqIDwgMzI7IGJp
dCA8PD0gMSwgaisrKSB7Ci0gICAgICAgICAgICAgICAgaWYgKHN0YXR1cyAmIGJpdCkgewotICAg
ICAgICAgICAgICAgICAgICAgICAgaXJxID0gSFdfRVZFTlRfSVJRX0JBU0UgKyBqICsgKGxldmVs
IDw8IDUpOwotICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIGlycTsKLSAgICAgICAgICAg
ICAgICB9Ci0gICAgICAgIH0KLQotICAgICAgICAvKiBOb3QgcmVhY2hlZCAqLwotICAgICAgICBy
ZXR1cm4gaXJxOworCV9fdTMyIGVtciwgZXNyLCBzdGF0dXMsIGxldmVsOworCV9fdTMyIGosIGJp
dDsKKworCXN3aXRjaCAoaXJxKSB7CisJCWNhc2UgMTM6CisJCQlsZXZlbCA9IDA7CisJCQlicmVh
azsKKwkJY2FzZSAxMToKKwkJCWxldmVsID0gMTsKKwkJCWJyZWFrOworCQljYXNlICA5OgorCQkJ
bGV2ZWwgPSAyOworCQkJYnJlYWs7CisJCWRlZmF1bHQ6CisJCQlyZXR1cm4gaXJxOworCX0KKwll
bXIgPSBFTVJfQkFTRSArIChsZXZlbCA8PCA0KSArIChsZXZlbCA8PCAyKTsKKwllc3IgPSBFU1Jf
QkFTRSArIChsZXZlbCA8PCAyKTsKKworCS8qIE1hc2sgdGhlIEVTUiB0byBmaWx0ZXIgYW55IHNw
dXJpb3VzLCB1bndhbnRlZCBpbnRlcnJ1cHRzICovCisJc3RhdHVzID0gaW5sKGVzcik7CisJc3Rh
dHVzICY9IGlubChlbXIpOworCisJLyogTm93IHNjYW4gYW5kIGZpbmQgdGhlIGZpcnN0IHNldCBi
aXQgYXMgdGhlIGV2ZW50IHRvIG1hcCAqLworCWZvciAoYml0ID0gMSwgaiA9IDA7IGogPCAzMjsg
Yml0IDw8PSAxLCBqKyspIHsKKwkJaWYgKHN0YXR1cyAmIGJpdCkgeworCQkJaXJxID0gSFdfRVZF
TlRfSVJRX0JBU0UgKyBqICsgKGxldmVsIDw8IDUpOworCQkJcmV0dXJuIGlycTsKKwkJfQorCX0K
KworCS8qIE5vdCByZWFjaGVkICovCisJcmV0dXJuIGlycTsKIH0K

--Multipart=_Tue__18_Nov_2008_17_28_47_+0100_RsI=YOatyJNQrKev--

--Signature=_Tue__18_Nov_2008_17_28_47_+0100_0tzx9si6iJ3hMTNJ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkki7T8ACgkQPQls10ERAGdvxwCgmzg7l9eJVYuaao25+tlmGier
vVgAnipKEHFrjY8oCLXrGpOHZe5MGSX5
=dbGD
-----END PGP SIGNATURE-----

--Signature=_Tue__18_Nov_2008_17_28_47_+0100_0tzx9si6iJ3hMTNJ--
