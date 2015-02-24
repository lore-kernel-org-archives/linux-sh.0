From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 24 Feb 2015 14:43:19 +0000
Subject: Re: [PATCH 0/2] Add R8A7794 GPIO DT support
Message-Id: <54EC8E07.1030301@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <6954455.LyoCrfjM8R@wasted.cogentembedded.com>
 <20150223220030.GA29878@verge.net.au> <20150223231901.GD29878@verge.net.au>
In-Reply-To: <20150223231901.GD29878@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello.

On 02/24/2015 02:19 AM, Simon Horman wrote:

>>>     Here's the set of 2 patches against Simon Horman's 'renesas.git' repo,
>>> 'renesas-devel-20150220-v3.19' tag. Here we add the GPIO device tree support
>>> for the R8A7794 SoC. It depends on the R8A7794 PFC/MMCIF device tree patches
>>> posted recently in order to apply.

>>> [1/2] ARM: shmobile: r8a7794: add GPIO clocks
>>> [2/2] ARM: shmobile: r8a7794: add GPIO DT support

>> Thanks,  I have queued these up with Geert's Acks.

> Sorry, I was too hasty again. I have dropped these pending the
> dependencies being queued up.

    Ah, I just didn't mention that the PFC patch is necessary for the latter 
patch to compile (but I don't expect it to change, so IMHO you can apply the 
PFC patch now). The former patch still can be merged, I think.

WBR, Sergei

