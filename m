From: Rob Landley <rob@landley.net>
Date: Tue, 31 Jul 2018 17:19:08 +0000
Subject: Boot time warning in today's git.
Message-Id: <3a3de5b1-2fa3-2b48-bd41-ff55f68e747b@landley.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------36B0885E5EF4F18AE4F863F1"
List-Id: <linux-sh.vger.kernel.org>
To: linux-sh@vger.kernel.org

This is a multi-part message in MIME format.
--------------36B0885E5EF4F18AE4F863F1
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

My https://github.com/landley/mkroot build (from the attached miniconfig) did:

Freeing unused kernel memory: 116K
This architecture does not have kernel memory protection.
WARNING: CPU: 0 PID: 1 at mm/slub.c:2412 ___slab_alloc.constprop.34+0x196/0x288

CPU: 0 PID: 1 Comm: swapper Not tainted 4.18.0-rc4 #1
PC is at ___slab_alloc.constprop.34+0x196/0x288
PR is at __slab_alloc.constprop.33+0x2a/0x4c
PC  : 8c09adbe SP  : 8f829ea8 SR  : 400080f0
TEA : c0001240
R0  : 8c09ac28 R1  : 8c01cc54 R2  : 8ff750d0 R3  : 00000000
R4  : 8f802780 R5  : 006080c0 R6  : 8c01d79c R7  : 8ff750d0
R8  : 8c011bd8 R9  : 8ff750d0 R10 : 8f802780 R11 : 00008000
R12 : 8c01d79c R13 : 006080c0 R14 : 8f8027fc
MACH: 00000231 MACL: 0ae4849d GBR : 00000000 PR  : 8c09aeda

Call trace:
 [<(ptrval)>] arch_local_irq_restore+0x0/0x24
 [<(ptrval)>] __do_softirq+0xbe/0x1ec
 [<(ptrval)>] __slab_alloc.constprop.33+0x2a/0x4c
 [<(ptrval)>] arch_local_save_flags+0x0/0x8
 [<(ptrval)>] arch_local_irq_restore+0x0/0x24
 [<(ptrval)>] mm_init.isra.6+0xb4/0x104
 [<(ptrval)>] kmem_cache_alloc+0x9c/0xf4
 [<(ptrval)>] arch_local_irq_restore+0x0/0x24
 [<(ptrval)>] mm_init.isra.6+0xb4/0x104
 [<(ptrval)>] mm_init.isra.6+0xb4/0x104
 [<(ptrval)>] __do_execve_file+0x1da/0x5bc
 [<(ptrval)>] kmem_cache_alloc+0x0/0xf4
 [<(ptrval)>] arch_local_irq_restore+0x0/0x24
 [<(ptrval)>] arch_local_save_flags+0x0/0x8
 [<(ptrval)>] do_execve+0x16/0x24
 [<(ptrval)>] arch_local_save_flags+0x0/0x8
 [<(ptrval)>] arch_local_irq_restore+0x0/0x24
 [<(ptrval)>] printk+0x0/0x24
 [<(ptrval)>] kernel_init+0x34/0xec
 [<(ptrval)>] ret_from_kernel_thread+0xc/0x14
 [<(ptrval)>] schedule_tail+0x0/0x54
 [<(ptrval)>] kernel_init+0x0/0xec

---[ end trace b8dd3009d023a164 ]---
8139cp 0000:00:02.0 eth0: link up, 100Mbps, full-duplex, lpa 0x05E1
Type exit when done.


--------------36B0885E5EF4F18AE4F863F1
Content-Type: text/plain; charset=UTF-8;
 name="sh4.miniconf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="sh4.miniconf"

IyBtYWtlIEFSQ0g9c2ggYWxsbm9jb25maWcgS0NPTkZJR19BTExDT05GSUc9c2g0Lm1pbmlj
b25mCiMgbWFrZSBBUkNIPXNoIC1qICQobnByb2MpCiMgYm9vdCBhcmNoL3NoL2Jvb3Qveklt
YWdlCgoKQ09ORklHX0NQVV9TVUJUWVBFX1NINzc1MVI9eQpDT05GSUdfTU1VPXkKQ09ORklH
X01FTU9SWV9TVEFSVD0weDBjMDAwMDAwCkNPTkZJR19WU1lTQ0FMTD15CkNPTkZJR19TSF9G
UFU9eQpDT05GSUdfU0hfUlRTNzc1MVIyRD15CkNPTkZJR19SVFM3NzUxUjJEX1BMVVM9eQpD
T05GSUdfU0VSSUFMX1NIX1NDST15CkNPTkZJR19TRVJJQUxfU0hfU0NJX0NPTlNPTEU9eQoK
Q09ORklHX1BDST15CkNPTkZJR19ORVRfVkVORE9SX1JFQUxURUs9eQpDT05GSUdfODEzOUNQ
PXkKCkNPTkZJR19QQ0k9eQpDT05GSUdfQkxLX0RFVl9TRD15CkNPTkZJR19BVEE9eQpDT05G
SUdfQVRBX1NGRj15CkNPTkZJR19BVEFfQk1ETUE9eQpDT05GSUdfUEFUQV9QTEFURk9STT15
CgpDT05GSUdfQklORk1UX0VMRl9GRFBJQz15CkNPTkZJR19CSU5GTVRfRkxBVD15CgojQ09O
RklHX1NQST15CiNDT05GSUdfU1BJX1NIX1NDST15CiNDT05GSUdfTUZEX1NNNTAxPXkKCiND
T05GSUdfUlRDX0NMQVNTPXkKI0NPTkZJR19SVENfRFJWX1I5NzAxPXkKI0NPTkZJR19SVENf
RFJWX1NIPXkKI0NPTkZJR19SVENfSENUT1NZUz15CgoKIyBDT05GSUdfRU1CRURERUQgaXMg
bm90IHNldApDT05GSUdfRUFSTFlfUFJJTlRLPXkKQ09ORklHX0JJTkZNVF9FTEY9eQpDT05G
SUdfQklORk1UX1NDUklQVD15CkNPTkZJR19OT19IWj15CkNPTkZJR19ISUdIX1JFU19USU1F
UlM9eQoKQ09ORklHX0JMS19ERVY9eQpDT05GSUdfQkxLX0RFVl9JTklUUkQ9eQpDT05GSUdf
UkRfR1pJUD15CgpDT05GSUdfQkxLX0RFVl9MT09QPXkKQ09ORklHX0VYVDRfRlM9eQpDT05G
SUdfRVhUNF9VU0VfRk9SX0VYVDI9eQpDT05GSUdfVkZBVF9GUz15CkNPTkZJR19GQVRfREVG
QVVMVF9VVEY4PXkKQ09ORklHX01JU0NfRklMRVNZU1RFTVM9eQpDT05GSUdfU1FVQVNIRlM9
eQpDT05GSUdfU1FVQVNIRlNfWEFUVFI9eQpDT05GSUdfU1FVQVNIRlNfWkxJQj15CkNPTkZJ
R19ERVZUTVBGUz15CkNPTkZJR19ERVZUTVBGU19NT1VOVD15CkNPTkZJR19UTVBGUz15CkNP
TkZJR19UTVBGU19QT1NJWF9BQ0w9eQoKQ09ORklHX05FVD15CkNPTkZJR19QQUNLRVQ9eQpD
T05GSUdfVU5JWD15CkNPTkZJR19JTkVUPXkKQ09ORklHX0lQVjY9eQpDT05GSUdfTkVUREVW
SUNFUz15CiNDT05GSUdfTkVUX0NPUkU9eQojQ09ORklHX05FVENPTlNPTEU9eQpDT05GSUdf
RVRIRVJORVQ9eQoK
--------------36B0885E5EF4F18AE4F863F1--
