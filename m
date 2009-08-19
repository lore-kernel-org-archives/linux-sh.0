From: pHilipp Zabel <philipp.zabel@gmail.com>
Date: Wed, 19 Aug 2009 13:52:08 +0000
Subject: Re: [alsa-devel] [PATCH 2/3] Add ak464x codec support
Message-Id: <74d0deb30908190652h78df814dlc6eda9c81be9b424@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <uk51059ln.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uk51059ln.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Cc: alsa-devel@alsa-project.org, linux-sh@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, broonie@opensource.wolfsonmicro.com, Magnus Damm <magnus.damm@gmail.com>, lethal@linux-sh.org

Hi,

On Wed, Aug 19, 2009 at 1:25 PM, Kuninori
Morimoto<morimoto.kuninori@renesas.com> wrote:
> This is very simple driver for ALSA
> It supprt headphone output and stereo input only
>
> Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
[...]
> diff --git a/sound/soc/codecs/ak464x.c b/sound/soc/codecs/ak464x.c
> new file mode 100644
> index 0000000..d2ef80d
> --- /dev/null
> +++ b/sound/soc/codecs/ak464x.c
> @@ -0,0 +1,525 @@
> +/*
> + * ak464x.c =A0-- =A0AK464x ALSA Soc Audio driver
[...]

Should this driver also be able to drive AK4641? I'm asking because I
was going to submit a driver for that chip, written by Harald Welte,
which I updated for the new device model registration:

http://git.linuxtogo.org/?p=3Dph5/kernel.git;a=3Dcommit;h=A5d321110db38c4f4=
69c2b8c438b3509ef3b20d1

AK4641 only seems to have registers 0x00 to 0x13, so if it is
sufficiently different to warrant a separate driver, maybe this driver
should be renamed to AK4643 or whatever is the lowest numbered AK464x
that has the register layout in your patch.

regards
Philipp
