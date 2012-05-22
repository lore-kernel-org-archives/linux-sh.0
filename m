From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 22 May 2012 04:41:54 +0000
Subject: Re: [PATCH 02/11] ARM: mach-shmobile: setup-r8a7740: add MERAM work-around
Message-Id: <20120522044154.GD22483@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <87fwatar29.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87fwatar29.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, May 21, 2012 at 09:27:03PM -0700, Kuninori Morimoto wrote:
> > If this exists within the MERAM register space, it should probably be
> > handled in the MERAM driver itself. If this is all going to go to DT in
> > the future it will be easy to to node to quirk matching then, but in the
> > mean time we can match on CPU or machine types.
> 
> It is difficult. 
> A1 MERAM datasheet doesn't have detail explain / register map.

Yes, I'm familiar with the quality/reliability of our documentation.

> It just say
> 
> ------------------------------------------
> Set the following register in the MERAM
>  Register name: ICBR buffer control
>  Address: H?$B!GFE95 0098 
>  Access size: 32 bits 
>  Initial value: H?$B!G0160 0168 
>  Setting value: H?$B!G0160 0164 
> ------------------------------------------
> 
> This work-around fixup MERAM memroy access erorr bug
> (CEU/VIO6C/2D-DMAC/VCP1/VPU5F/JPU/DISP)
> But we don't know what is these value.
> 
The problem with doing these sorts of setting outside of the context of
the MERAM driver is that the MERAM driver could just turn around and undo
the work by setting whatever bit this workaround is clearing.

As long as this exists outside of the MERAM register map and we don't
have to worry about the MERAM driver touching these values then having it
as a board-specific thing is probably fine. If it falls within the MERAM
mapping somewhere then the MERAM driver really should be dealing with it
(or we can set it as a board-specific thing when the MERAM driver isn't
being used), even if it is a magic value for the given CPU.

The main thing is avoiding subtle hard to debug problems where the board
config workarounds are inadvertently trampled later on.
