From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Thu, 06 Mar 2014 04:34:25 +0000
Subject: Re: [PATCH 2/2] serial: sh-sci: Add missing call to uart_remove_one_port() in failure path
Message-Id: <20140306043425.GA24704@kroah.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1393593694-30262-1-git-send-email-geert@linux-m68k.org>
 <1393593694-30262-2-git-send-email-geert@linux-m68k.org>
 <20140306041912.GB29693@verge.net.au>
In-Reply-To: <20140306041912.GB29693@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Jiri Slaby <jslaby@suse.cz>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@linux-m68k.org>

On Thu, Mar 06, 2014 at 01:19:13PM +0900, Simon Horman wrote:
> On Fri, Feb 28, 2014 at 02:21:33PM +0100, Geert Uytterhoeven wrote:
> > From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
> > 
> > If cpufreq_register_notifier() fails, we have to remove the port added by
> > sci_probe_single(), which is not done by sci_cleanup_single().
> > 
> > Else the serial port stays active from the point of view of the serial
> > subsystem, and it may crash when userspace getty is started, or when the
> > loadable driver module is unloaded.
> > 
> > This was introduced by commit 6dae14216c85eea13db7b12c469475c5d30e5499
> > ("serial: sh-sci: Fix probe error paths").
> > 
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
> 
> Acked-by: Simon Horman <horms+renesas@verge.net.au>
> 
> This looks reasonable to me.
> 
> Greg, could you take this one?

Will do, thanks.
