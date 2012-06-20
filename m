From: John Crispin <john@phrozen.org>
Date: Wed, 20 Jun 2012 07:09:14 +0000
Subject: Re: [PATCH] MIPS: fix bug.h MIPS build regression
Message-Id: <4FE1771A.8070703@phrozen.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1339962373-3224-1-git-send-email-geert@linux-m68k.org>        <CAMuHMdVfLjgrtWoPpvbLf12+=ApE6W9dNcweqD-_2Benr-D7NQ@mail.gmail.com> <20120620152759.2caceb8c.yuasa@linux-mips.org>
In-Reply-To: <20120620152759.2caceb8c.yuasa@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoichi Yuasa <yuasa@linux-mips.org>
Cc: linux-kernel@vger.kernel.org, Linuxppc-dev <linuxppc-dev@ozlabs.org>, Linux MIPS Mailing List <linux-mips@linux-mips.org>, Linux-sh list <linux-sh@vger.kernel.org>

On 20/06/12 08:27, Yoichi Yuasa wrote:
> Commit: 3777808873b0c49c5cf27e44c948dfb02675d578 breaks all MIPS builds.
> 

Hi Yoichi,

I stumbled across the same build regression last night and came up with
almost the same fix :-)

Tested-by: John Crispin <blogic@openwrt.org>

Thanks,
John
