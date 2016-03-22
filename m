From: Rich Felker <dalias@libc.org>
Date: Tue, 22 Mar 2016 20:51:58 +0000
Subject: Re: FROZEN transition in hotplug notifier
Message-Id: <20160322205158.GF21636@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <alpine.DEB.2.11.1603221817270.30089@hypnos>
In-Reply-To: <alpine.DEB.2.11.1603221817270.30089@hypnos>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Mar 22, 2016 at 06:20:48PM +0100, Anna-Maria Gleixner wrote:
> Hi,
> 
> the hotplug notifier in arch/sh/kernel/cpu/sh4a/smp-shx3.c doesn't
> handle the corresponding FROZEN transitions. Is there a reason for it?

Hi,

Is this an issue you're hitting or just something you noticed reading
the source? Not that this affects the validity of your observation,
but I have no idea where to get SH-X3 hardware, whether anyone is
actually using it, and whether such transitions make sense as
something that can actually happen on the hardware. I'm hoping to pick
up more legacy SH hardware and documentation to be able to check out
things like this.

Rich
