From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 26 Aug 2011 08:44:04 +0000
Subject: Re: [PATCH][RESEND] ARM: mach-shmobile: sh7372 generic suspend/resume support
Message-Id: <CANqRtoQddrnu74qpUyoK=ovi9UbNpWWJzSJasRak_6aCwxyyfw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20110826051205.24370.44903.sendpatchset@rxone.opensource.se>
In-Reply-To: <20110826051205.24370.44903.sendpatchset@rxone.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Fri, Aug 26, 2011 at 5:25 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> Who are you wanting to merge your patch?
>
> To: linux-sh@vger.kernel.org
> Cc: rjw@sisk.pl, Magnus Damm <magnus.damm@gmail.com>, lethal@linux-sh.org,
> =A0 =A0 =A0 =A0linux@arm.linux.org.uk
>
> Generally, the person who you want to apply the patch goes into the
> To: line - so I'm interpreting your message as you want someone on
> linux-sh to merge your patch - I'm presuming Paul rather than me.
> Is that correct?

Thanks for your reply!

Good question. This was posted before the 3.1-rc merge window, but
didn't make it into mainline for some unknown
reason. I'm all for merging things sooner than later if possible, but
I understand if 3.1-rc is out of the question at this point.

If you are offering to queue this up for the 3.2 merge window then I
am instead suggesting that Rafael picks this up in his PM tree because
there are other PM related patches that build on top of this one.

While at it, for the 3.1 release, would it be possible to update the
mach-types list in mainline? We have patches for the Kota2 board that
depend on the mach-type update.

Thanks!

/ magnus
