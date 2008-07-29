From: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
Date: Tue, 29 Jul 2008 05:33:37 +0000
Subject: Re: sh se7750_defconfig compile error
Message-Id: <488EABB1.2070008@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20080728214039.GE7713@cs181140183.pp.htv.fi>
In-Reply-To: <20080728214039.GE7713@cs181140183.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian Bunk <bunk@kernel.org>
Cc: Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Hi, Adrian.

Thank you for your check and report.

I will fix this soon.

Best regards,
  Nobuhiro

Adrian Bunk wrote:
> Commit ffb91ad2751723bcc9925cd38e37013e2169e256
> (sh: Solution Enginge 7710/7712 SH-Ether support)
> causes the following compile error with se7750_defconfig:
> 
> <--  snip  -->
> 
> ...
>   CC      arch/sh/boards/se/770x/setup.o
> /home/bunk/linux/kernel-2.6/git/linux-2.6/arch/sh/boards/se/770x/setup.c:134: error: 'PHY_ID' undeclared here (not in a function)
> make[2]: *** [arch/sh/boards/se/770x/setup.o] Error 1
> 
> <--  snip  -->
> 
> The patch did:
> #if defined(CONFIG_CPU_SUBTYPE_SH7710)
> # define PHY_ID 0x00
> #elif defined(CONFIG_CPU_SUBTYPE_SH7712)
> # define PHY_ID 0x01
> #endif
> 
> But in this case we have CONFIG_CPU_SUBTYPE_SH7750.
> 
> cu
> Adrian
> 

