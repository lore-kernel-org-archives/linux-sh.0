From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 08 Aug 2008 05:53:07 +0000
Subject: Re: [PATCH 1/2] sh_eth Add SH7619 support (platform)
Message-Id: <20080808055307.GA3319@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <87iqudzon8.wl%ysato@users.sourceforge.jp>
In-Reply-To: <87iqudzon8.wl%ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Aug 06, 2008 at 07:53:31PM -0400, Yoshinori Sato wrote:
> Add EDMAC endian infomation.
> 
>  arch/sh/boards/mach-se/770x/setup.c   |   10 ++++++++--
>  arch/sh/kernel/cpu/sh2/setup-sh7619.c |    9 ++++++++-
>  2 files changed, 16 insertions(+), 3 deletions(-)
> 
I'll apply this and Iwamatsu-san's mach-sh7763rdp sh_eth bits once the
EDMAC endian bits hit mainline.
