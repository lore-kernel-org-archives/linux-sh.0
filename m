From: yoshii.takashi@renesas.com
Date: Thu, 27 Aug 2009 03:01:03 +0000
Subject: Re: [BUG] arch/sh/include/mach-common/mach/sh7785lcr.h:
Message-Id: <20090827120103.a24e8837.yoshii.takashi@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4A95800A.7020603@gentoo.org>
In-Reply-To: <4A95800A.7020603@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Oh, sorry.
This might be because the board I sent you was a special version.
You (and possibly others who use this version) should revert that commit.
I'm really sorry for inconvenient.

Paul, are there any good way to support this kind of small differences?
Is it ok to add configuration menu item like below?

--- a/arch/sh/boards/Kconfig
+++ b/arch/sh/boards/Kconfig
@@ -171,6 +171,15 @@ config SH_SH7785LCR_29BIT_PHYSMAPS
          DIP switch(S2-5). If you set the DIP switch for S2-5 = ON,
          you can access all on-board device in 29bit address mode.
 
+config SH_SH7785LCR_VERSION
+       int "SH7785LCR board version"
+       depends on SH_SH7785LCR
+       default "1"
+       help
+         There are two versions of the boards known.
+         Set 0 for old, pre mass-product version.
+         Set 1 for all the other.
+
 config SH_URQUELL
        bool "Urquell"
        depends on CPU_SUBTYPE_SH7786

/yoshii
