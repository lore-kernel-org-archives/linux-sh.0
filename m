From: Mark Brown <broonie@kernel.org>
Date: Tue, 06 Nov 2018 15:46:59 +0000
Subject: Re: [alsa-devel] Build regressions/improvements in v4.20-rc1 (sound/pci/hda/patch_ca0132.c)
Message-Id: <20181106154659.GA31950@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="0OAP2g/MAC+5xKAE"
List-Id: <linux-sh.vger.kernel.org>
References: <20181105220559.27458-1-geert@linux-m68k.org>
 <CAMuHMdWGpjvwunNWgFujPO9_j+=QiNsi346s4-xBF1g4DT5xZw@mail.gmail.com>
 <80f2f98b-9ab1-2a1c-0962-63e3be1dd742@infradead.org>
 <CAMuHMdViTrKqQzci3=YJzk2+kQKqbWcr0oaaR1ZQM_VqT33RvA@mail.gmail.com>
 <eccd20fa-5be3-957d-7905-9cc4021ba94e@linux.intel.com>
In-Reply-To: <eccd20fa-5be3-957d-7905-9cc4021ba94e@linux.intel.com>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: linux-s390 <linux-s390@vger.kernel.org>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Linux-sh list <linux-sh@vger.kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 06, 2018 at 08:56:39AM -0600, Pierre-Louis Bossart wrote:

> > However, looking at what else can enable SND_HDA, I think it should be

> >      select SND_SOC_HDAC_HDA if SND_PCI || ARCH_TEGRA

> This codec can only be used by the Skylake driver (and the upcoming SOF
> one). For Tegra this module will never be used unless they follow the same
> path of enabling ASoC to deal with the HDaudio codecs instead of the legacy.

> Likewise HDAC_HDMI will only work on Intel platforms for now.

_ALL_CODECS is a build coverage option, not a useful configuration
option.  We should be building things in as many different
configurations as possible so that it's easier for people to get build
coverage when making subsystem wide changes.

--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvht3EACgkQJNaLcl1U
h9Deagf+OnHg8fBz8mKu9ehkKNp8xTUnAUdpPtoS0edsuI0QuH1I5WbIs6F3Ro58
cxf6scOiMI7R0/qne0h0ReQbOudbh0mT0aCBL1UP77FGvWhkgpJF8CkJP5Hwl+MB
eFtQe4CE0IfCXtzbfhg+RZ22OkUmJ4Rgdue5yqS7fPHswqQb/7zMGXZpKYGHuJx5
T1Dhj5dnKqI7pS8lThDzcA/ZtkBbST4aN+Zv1RvI9ew6pVMrYWq30QSohmx2+qTs
A9ESsst56DEvX8RSIZcsqMNejmuXFIQ4L7dqyIjS/9FjLoG1fp5SUkSOd4p6NHoo
BBLuGM/ddEXdoSs7PJGNuK+CihZHtA==
=wMGV
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--
