From: Rich Felker <dalias@libc.org>
Date: Tue, 07 Apr 2020 15:21:12 +0000
Subject: Re: v5.6 is still throwing a stack trace on boot.
Message-Id: <20200407152112.GK11469@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <24dbbbc2-644a-1f9e-4e82-b7b726a4ce42@landley.net>
In-Reply-To: <24dbbbc2-644a-1f9e-4e82-b7b726a4ce42@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Apr 07, 2020 at 09:21:26AM -0500, Rob Landley wrote:
> On 4/3/20 7:51 PM, Rich Felker wrote:
> > On Fri, Apr 03, 2020 at 07:28:27PM -0500, Rob Landley wrote:
> >>>> ---[ end trace 76213c1325250d90 ]---
> >>>
> >>> Which hardware is this on? The qemu emulated board you're using?
> >>
> >> Yes, qemu -M r2d. Built with attached miniconf, and run via:
> >>
> >> qemu-system-sh4 -M r2d -serial null -serial mon:stdio -nographic -no-reboot \
> >>   -m 256 -append "panic=1 HOST=sh4 console=ttySC1 noiotrap" -kernel zImage \
> >>   -initrd sh4.cpio.gz
> > 
> > OK. This is nbd, it's just some pedantry added in commit
> > 128227e7fe4087b60f1bd31f762e61237eb23790. Essentially it's complaining
> > that something requested zero-filled slab memory when it's about to
> > run a constructor to fill in the memory. The backtrace is (as usual)
> > somewhat bogus looking and grep isn't helping me find where it's being
> > called from. I'll keep looking and see if I can track it down.
> 
> Did you?
> 
> Also, https://marc.info/?l=linux-sh&m8544749818664&w=2 still doesn't seem to
> be upstream?

See Geert's reply,

Message-ID: <CAMuHMdVm-871S5tOdQw0KbRao+L0Wg46Rk3yNRyW45zJf3qt4w@mail.gmail.com>

I think the patch is correct but still don't thoroughly understand it
(in terms of where these functions are used and whether it preserves
the property that everything that needs zero-fill gets it). Will
follow up soon.

Rich
