From: Mark Brown <broonie@kernel.org>
Date: Tue, 07 Oct 2014 12:38:56 +0000
Subject: Re: [PATCH] ASoC: simple-card: Add mic and hp detect gpios.
Message-Id: <20141007123856.GF4609@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="0rEjiS+nMGFQ7Kkj"
List-Id: <linux-sh.vger.kernel.org>
References: <1412198720-2326-1-git-send-email-dgreid@chromium.org>
 <20141002155350.GU4273@sirena.org.uk>
 <CAMuHMdWh=sXAD59T1T=gvROX+fbF6=gFo6C0nkJdfnCrdNrwYg@mail.gmail.com>
In-Reply-To: <CAMuHMdWh=sXAD59T1T=gvROX+fbF6=gFo6C0nkJdfnCrdNrwYg@mail.gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Dylan Reid <dgreid@chromium.org>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, jay.xu@rock-chips.com, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, sonnyrao@chromium.org, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>


--0rEjiS+nMGFQ7Kkj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 07, 2014 at 02:32:57PM +0200, Geert Uytterhoeven wrote:

> Hence on r8a7740/armadillo-legacy, which uses platform devices instead of DT:

>     sh-mobile-hdmi sh-mobile-hdmi: SH Mobile HDMI Audio Codec
>     sh-mobile-hdmi sh-mobile-hdmi: ASoC: DAPM unknown pin Headphones
>     sh-mobile-hdmi sh-mobile-hdmi: ASoC: DAPM unknown pin Mic Jack

> After that the kernel log is spammed ca. 7 times per second with:

>     sh-mobile-hdmi sh-mobile-hdmi: ASoC: DAPM unknown pin Headphones

> Reverting commit 3fe240326cc395c66 ("ASoC: simple-card: Add mic and
> hp detect gpios.") fixes this.

The fix here is to not allow 0 as a GPIO in the core code (which
should've been there already).

--0rEjiS+nMGFQ7Kkj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUM97fAAoJECTWi3JdVIfQgtwH/i+yPeaZ+B5GLPdNvOkI9xwh
RhJDZX600KVNGxpTjx4Qvgl03QnQEm63sNGzHTAZOvGR7L2NlmPimIq9DFMfMpWg
dB4HAYiq2h0AN8be1sFmSaRlvEz5Wa1KWY+sxKYbJI3lGVRAaQlVtFkNzBZvac2l
mljjnWa3aZa7uRNwad+ygxfMyB1b3nFg6O5aUuWooYQo86ZONTrNKt2Dbuhg3ckQ
3xnlLdcOoB3QLisnxoE9duV/F+60bkqakS1BrFkgM8rRWxKVDsDENv9RKfzCU6po
reBOZIitIgUR7jfTWi5poaXhyfZZtEAV+batFEGQWzQGSPyAtRdQQqVm991uP3k=
=SH2v
-----END PGP SIGNATURE-----

--0rEjiS+nMGFQ7Kkj--
