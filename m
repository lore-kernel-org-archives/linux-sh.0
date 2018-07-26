From: Ben Hutchings <ben@decadent.org.uk>
Date: Thu, 26 Jul 2018 07:01:25 +0000
Subject: [PATCH RESEND] sh: Do not use hyphen in exported variable names
Message-Id: <20180726070125.GS14131@decadent.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="FiqEyLLt06qkB6ow"
List-Id: <linux-sh.vger.kernel.org>
To: linux-sh@vger.kernel.org


--FiqEyLLt06qkB6ow
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

arch/sh/Makefile defines and exports ld-bfd to be used by
arch/sh/boot/Makefile and arch/sh/boot/compressed/Makefile.  Similarly
arch/sh/boot/Makefile defines and exports suffix-y to be used by
arch/sh/boot/compressed/Makefile.  However some shells, including
dash, will not pass through environment variables whose name includes
a hyphen.  Usually GNU make does not use a shell to recurse, but if
e.g. $(srctree) contains '~' it will use a shell here.

Rename these variables to ld_bfd and suffix_y.

References: https://buildd.debian.org/status/fetch.php?pkg=3Dlinux&arch=3Ds=
h4&ver=3D4.13%7Erc5-1%7Eexp1&stamp=3D1502943967&raw=3D0
Fixes: ef9b542fce00 ("sh: bzip2/lzma uImage support.")
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/sh/Makefile                 | 10 +++++-----
 arch/sh/boot/Makefile            | 16 ++++++++--------
 arch/sh/boot/compressed/Makefile |  6 +++---
 arch/sh/boot/romimage/Makefile   |  4 ++--
 4 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/sh/Makefile b/arch/sh/Makefile
index 280bbff12102..496525557b60 100644
--- a/arch/sh/Makefile
+++ b/arch/sh/Makefile
@@ -116,16 +116,16 @@ KBUILD_DEFCONFIG	:=3D cayman_defconfig
 endif
=20
 ifdef CONFIG_CPU_LITTLE_ENDIAN
-ld-bfd			:=3D elf32-$(UTS_MACHINE)-linux
-LDFLAGS_vmlinux		+=3D --defsym jiffies=3Djiffies_64 --oformat $(ld-bfd)
+ld_bfd			:=3D elf32-$(UTS_MACHINE)-linux
+LDFLAGS_vmlinux		+=3D --defsym jiffies=3Djiffies_64 --oformat $(ld_bfd)
 LDFLAGS			+=3D -EL
 else
-ld-bfd			:=3D elf32-$(UTS_MACHINE)big-linux
-LDFLAGS_vmlinux		+=3D --defsym jiffies=3Djiffies_64+4 --oformat $(ld-bfd)
+ld_bfd			:=3D elf32-$(UTS_MACHINE)big-linux
+LDFLAGS_vmlinux		+=3D --defsym jiffies=3Djiffies_64+4 --oformat $(ld_bfd)
 LDFLAGS			+=3D -EB
 endif
=20
-export ld-bfd BITS
+export ld_bfd BITS
=20
 head-y	:=3D arch/sh/kernel/head_$(BITS).o
=20
diff --git a/arch/sh/boot/Makefile b/arch/sh/boot/Makefile
index 58592dfa5cb6..296b25474395 100644
--- a/arch/sh/boot/Makefile
+++ b/arch/sh/boot/Makefile
@@ -19,12 +19,12 @@ CONFIG_ZERO_PAGE_OFFSET	?=3D 0x00001000
 CONFIG_ENTRY_OFFSET	?=3D 0x00001000
 CONFIG_PHYSICAL_START	?=3D $(CONFIG_MEMORY_START)
=20
-suffix-y :=3D bin
-suffix-$(CONFIG_KERNEL_GZIP)	:=3D gz
-suffix-$(CONFIG_KERNEL_BZIP2)	:=3D bz2
-suffix-$(CONFIG_KERNEL_LZMA)	:=3D lzma
-suffix-$(CONFIG_KERNEL_XZ)	:=3D xz
-suffix-$(CONFIG_KERNEL_LZO)	:=3D lzo
+suffix_y :=3D bin
+suffix_$(CONFIG_KERNEL_GZIP)	:=3D gz
+suffix_$(CONFIG_KERNEL_BZIP2)	:=3D bz2
+suffix_$(CONFIG_KERNEL_LZMA)	:=3D lzma
+suffix_$(CONFIG_KERNEL_XZ)	:=3D xz
+suffix_$(CONFIG_KERNEL_LZO)	:=3D lzo
=20
 targets :=3D zImage vmlinux.srec romImage uImage uImage.srec uImage.gz \
 	   uImage.bz2 uImage.lzma uImage.xz uImage.lzo uImage.bin
@@ -106,10 +106,10 @@ OBJCOPYFLAGS_uImage.srec :=3D -I binary -O srec
 $(obj)/uImage.srec: $(obj)/uImage
 	$(call if_changed,objcopy)
=20
-$(obj)/uImage: $(obj)/uImage.$(suffix-y)
+$(obj)/uImage: $(obj)/uImage.$(suffix_y)
 	@ln -sf $(notdir $<) $@
 	@echo '  Image $@ is ready'
=20
 export CONFIG_PAGE_OFFSET CONFIG_MEMORY_START CONFIG_BOOT_LINK_OFFSET \
        CONFIG_PHYSICAL_START CONFIG_ZERO_PAGE_OFFSET CONFIG_ENTRY_OFFSET \
-       KERNEL_MEMORY suffix-y
+       KERNEL_MEMORY suffix_y
diff --git a/arch/sh/boot/compressed/Makefile b/arch/sh/boot/compressed/Mak=
efile
index c4c47ea9fa94..40fcc3d1a9c0 100644
--- a/arch/sh/boot/compressed/Makefile
+++ b/arch/sh/boot/compressed/Makefile
@@ -32,7 +32,7 @@ ORIG_CFLAGS :=3D $(KBUILD_CFLAGS)
 KBUILD_CFLAGS =3D $(subst -pg, , $(ORIG_CFLAGS))
 endif
=20
-LDFLAGS_vmlinux :=3D --oformat $(ld-bfd) -Ttext $(IMAGE_OFFSET) -e startup=
 \
+LDFLAGS_vmlinux :=3D --oformat $(ld_bfd) -Ttext $(IMAGE_OFFSET) -e startup=
 \
 		   -T $(obj)/../../kernel/vmlinux.lds
=20
 #
@@ -74,7 +74,7 @@ $(obj)/vmlinux.bin.lzo: $(vmlinux.bin.all-y) FORCE
=20
 OBJCOPYFLAGS +=3D -R .empty_zero_page
=20
-LDFLAGS_piggy.o :=3D -r --format binary --oformat $(ld-bfd) -T
+LDFLAGS_piggy.o :=3D -r --format binary --oformat $(ld_bfd) -T
=20
-$(obj)/piggy.o: $(obj)/vmlinux.scr $(obj)/vmlinux.bin.$(suffix-y) FORCE
+$(obj)/piggy.o: $(obj)/vmlinux.scr $(obj)/vmlinux.bin.$(suffix_y) FORCE
 	$(call if_changed,ld)
diff --git a/arch/sh/boot/romimage/Makefile b/arch/sh/boot/romimage/Makefile
index 43c41191de5d..8002c3ee2cac 100644
--- a/arch/sh/boot/romimage/Makefile
+++ b/arch/sh/boot/romimage/Makefile
@@ -12,7 +12,7 @@ mmcif-obj-$(CONFIG_CPU_SUBTYPE_SH7724)	:=3D $(obj)/mmcif-=
sh7724.o
 load-$(CONFIG_ROMIMAGE_MMCIF)		:=3D $(mmcif-load-y)
 obj-$(CONFIG_ROMIMAGE_MMCIF)		:=3D $(mmcif-obj-y)
=20
-LDFLAGS_vmlinux :=3D --oformat $(ld-bfd) -Ttext $(load-y) -e romstart \
+LDFLAGS_vmlinux :=3D --oformat $(ld_bfd) -Ttext $(load-y) -e romstart \
 		   -T $(obj)/../../kernel/vmlinux.lds
=20
 $(obj)/vmlinux: $(obj)/head.o $(obj-y) $(obj)/piggy.o FORCE
@@ -23,7 +23,7 @@ OBJCOPYFLAGS +=3D -j .empty_zero_page
 $(obj)/zeropage.bin: vmlinux FORCE
 	$(call if_changed,objcopy)
=20
-LDFLAGS_piggy.o :=3D -r --format binary --oformat $(ld-bfd) -T
+LDFLAGS_piggy.o :=3D -r --format binary --oformat $(ld_bfd) -T
=20
 $(obj)/piggy.o: $(obj)/vmlinux.scr $(obj)/zeropage.bin arch/sh/boot/zImage=
 FORCE
 	$(call if_changed,ld)

--FiqEyLLt06qkB6ow
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUBW1lxxOe/yOyVhhEJAQpq1RAAsWj601GupRPNtCkZLitAW4ASs1IPA7tM
JDgr1c5XfQUuHz7qXpxsvuKyoH72tmrxgMM+EuMg/rc5rDyaJncvJ/x06CWMOjAj
TLzc68yyDXVn51vlLoN6O9Uu2YmyXol6tR2tTnQbCAELqDTu6MJS91bo6Z7rE0oO
nstNDmDPyB/4cu4PiSTY1uwNsR+24wwoKDw00a4ctu8hZSdkGseYFOfMoM5fTwYx
Ss+Stu6eLfMlxrrw6xiPtWjB8vkPlYyQ/SSTjXRXSQHSxABOVw9SXnTlpNEF2Mxj
W7QJqDwiCYduAP+8Ukf6q4XFDBCAFY7kMkK4NCaxYsDNclM1lKSkNs7Z+Lage8zN
8Ma/XRELzstSXjJE04OrlNF0E+ITfimUJJqg0/Cf/qFewtLGBOccAf/psWdA0Hzm
gYcNTC++DlGKbvkrfJX1PlnXAiqloIsMhxHHMaisx4XTcLmi6Cbsw6vVRpHCY2GE
1VM/D1DvakPzfxRflpFKtnW+jHU2Q61/rbkVrbFhN59xEZFfJglh6iNmxyGomBU1
tCxG+syeZq7SBiVUsuPzZ8E5ujyIl2XteuYTxTF99QkcUkwoP/W0zFLeUFSTVgY0
K3tL4ZUG7mnHYm80KmmwFR4o7Cqc8jGpwMqbtwza2eQPDGIXPzT1w3+vp0k4JJ3X
7bRXVo5V8BI=
=5Jr+
-----END PGP SIGNATURE-----

--FiqEyLLt06qkB6ow--
