From: Markus Heiser <markus.heiser@darmarit.de>
Date: Mon, 15 Jul 2019 06:16:54 +0000
Subject: Re: [PATCH 8/8] docs: remove extra conf.py files
Message-Id: <e3ff0a8a-6956-3855-07be-9c126df2da2d@darmarit.de>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1563115732.git.mchehab+samsung@kernel.org>
 <12a160afc9e70156f671010bd4ccff9311acdc5e.1563115732.git.mchehab+samsung@kernel.org>
In-Reply-To: <12a160afc9e70156f671010bd4ccff9311acdc5e.1563115732.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@infradead.org>, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Sean Paul <sean@poorly.run>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-crypto@vger.kernel.org, dri-d

Hi Mauro,

sorry, I havn't tested your patch, but one question ...

Am 14.07.19 um 17:10 schrieb Mauro Carvalho Chehab:
> Now that the latex_documents are handled automatically, we can
> remove those extra conf.py files.

We need these conf.py also for compiling books' into HTML.  For this
the tags.add("subproject") is needed.  Should we realy drop this feature?

-- Markus --
