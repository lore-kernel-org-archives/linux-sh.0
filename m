From: Simon Horman <horms@verge.net.au>
Date: Thu, 05 Dec 2013 03:02:36 +0000
Subject: Re: [PATCH 09/11] ARM: shmobile: r8a7791: MSIOF platform device
Message-Id: <20131205030235.GG21443@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20131202031557.162e78d407d82effdee627ac@ops.dti.ne.jp>
 <1385921962-19843-1-git-send-email-takasi-y@ops.dti.ne.jp>
 <1385921962-19843-9-git-send-email-takasi-y@ops.dti.ne.jp>
 <CACRpkdbvrYgRh7cK0N1HrcxkYzzu9Qw4yAoQwj4f9pEf0r1qQw@mail.gmail.com>
In-Reply-To: <CACRpkdbvrYgRh7cK0N1HrcxkYzzu9Qw4yAoQwj4f9pEf0r1qQw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: takasi-y-nDL5PR/MsHhHfZP73Gtkiw@public.gmane.org, "linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Tue, Dec 03, 2013 at 11:12:32AM +0100, Linus Walleij wrote:
> On Sun, Dec 1, 2013 at 7:19 PM,  <takasi-y@ops.dti.ne.jp> wrote:
> 
> > From: Takashi Yoshii <takasi-y@ops.dti.ne.jp>
> >
> > Define resources for msiof0,1,2. HWM says there is msiof3, but omit
> > it because its clock, reset and irqs are not seen on HWM. Anyway, only
> > msiof0 is registerd, so far, because others lack of chance for testing.
> > msiof0 has id=1 (spi_sh_msiof.1), for a compatibility with BSP.
> >
> > Signed-off-by: Takashi Yoshii <takasi-y@ops.dti.ne.jp>
> 
> So why is this new shiny device not registered from the device
> tree instead of adding more hard-coded platform devices to the
> ARM tree? The add_standard_devices() seem to add everything
> from the DT just fine.
> 
> NAK.

Hi Linus,

the way that shmobile is handling moving to DT is multi-faceted.
One such facet is that we currently maintain two ways of booting each board.
One uses legacy-C code and initialises devices using platform devices.
The other, which we call -reference uses DT.

This patch is for the legacy-C board code to use.

This has been the approach that we have been taking for about a year now.
We have recently been giving some consideration to moving to the next stage
which we believe is to enable devices whose drivers don't have DT bindings
(yet) using DT in -reference. With this in place it should be possible
to plan removal of the legacy-C board code.

In the mean time I would prefer if we kept with the pattern that
we have been using up until now.
