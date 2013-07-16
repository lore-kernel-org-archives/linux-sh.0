From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 16 Jul 2013 12:28:37 +0000
Subject: Re: [PATCH v4 0/3]  ARM: shmobile: lager: enable Ether
Message-Id: <51E53C75.10904@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1372663234-13486-1-git-send-email-horms+renesas@verge.net.au>
 <7990652.CKWzcoj3FL@avalon>
In-Reply-To: <7990652.CKWzcoj3FL@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello.

On 16-07-2013 13:42, Laurent Pinchart wrote:

>> this short series enables the on-board ethernet
>> of the r8a7790 SoC for on lager board.

>> It has a run-time dependency on
>> "sh_eth: add support for r8a7790 SoC"

>> It has been built on top of renesas-next-20130701.

> Do you plan to respin this series on top of your latest devel branch ? I've
> quickly rebased it and now get receive FIFO overflows when booting over NFS,
> followed by the kernel disabling the sh-eth IRQ.

    That disabling of IRQ should have been fixed in 3.10.

WBR, Sergei

