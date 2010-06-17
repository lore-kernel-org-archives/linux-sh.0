From: Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
Date: Thu, 17 Jun 2010 09:14:53 +0000
Subject: Re: [PATCH v3 1/4] Add the directory mach-sh2007 for SH-2007 board
Message-Id: <4C19E78D.9050406@dcl.info.waseda.ac.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <1276231892-22850-2-git-send-email-mitake@dcl.info.waseda.ac.jp>
In-Reply-To: <1276231892-22850-2-git-send-email-mitake@dcl.info.waseda.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 06/11/10 13:51, Hitoshi Mitake wrote:
 > This patch adds directory for SH-2007 support and modify 
tools/mach-types.
 > mach-sh2007/setup.c ... Setup platform devices and provide machine 
vector.
 > tools/mach-types ... Added entry of SH2007 for mach_is_sh2007()
 >
 > CAUTION: IDE support is not tested yet.
 > 	 I'll be able to obtain cable for 2.5 inch HDD,
 > 	 then I'll test this device.

Sadly, my plan to obtain the cable for 2.5 inch HDD is failed.
I cannot predict when I can test IDE support of SH-2007.

Should I remove IDE support?
