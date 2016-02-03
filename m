From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 03 Feb 2016 15:05:41 +0000
Subject: Re: [PATCH v2 0/3] drm: adv7511: edid read fixes
Message-Id: <20160203150540.GA10027@tetsubishi>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="h31gzZEtNLTqOjlF"
List-Id: <linux-sh.vger.kernel.org>
References: <1452290210-20629-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1452290210-20629-1-git-send-email-wsa@the-dreams.de>
To: dri-devel@lists.freedesktop.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, linux-sh@vger.kernel.org


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

David,

can you pull in these patches which have been around for some time now
and have been acked/reviewed by relevant people? The branch is based on
your next branch as of yesterday.

Thanks,

   Wolfram

The following changes since commit 1df59b8497f47495e873c23abd6d3d290c730505:

  Merge tag 'drm-intel-next-fixes-2016-01-14' of git://anongit.freedesktop.org/drm-intel into drm-next (2016-01-18 07:02:19 +1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git drm/adv7511

for you to fetch changes up to 29ce4ed441d04a8931150f291c0f7d961690ab81:

  drm: adv7511: it's HPD, not HDP (2016-02-02 15:37:55 +0100)

----------------------------------------------------------------
Wolfram Sang (3):
      drm: adv7511: really enable interrupts for EDID detection
      drm: adv7511: mark ADV7511_REG_EDID_READ_CTRL volatile
      drm: adv7511: it's HPD, not HDP

 drivers/gpu/drm/i2c/adv7511.c | 48 +++++++++++++++++++++++++++++-------------------
 drivers/gpu/drm/i2c/adv7511.h | 12 ++++++------
 2 files changed, 35 insertions(+), 25 deletions(-)


--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWshdEAAoJEBQN5MwUoCm2hDIQAIX+0E6jDUMhJT1APD9lwFHj
Kbnf4S3hB4xcwJv2FFLRHk7QZx+XPwxTEQa5WHLTSCG2Z1enlyQuI9MFDK7AjDun
OjHs0+sUQ0ii+dmjSvNlyw3TZWAS0L0dhA8R44/UfeV52acR2D1u7UVGLsHmd8e3
REhytBkj4+HKtXLWVI21QW19+untBCqyyEdGcBRt2pSEslnHhvQvwGmRulMpxBiz
+s/0lGcNdww6DjNTVx+cyTXkxVwqvFYbkpLp1KFE0j8t9MZIkd63A4ZDgSDnVQN7
owenIgllIgGLlwyGaON+E+82GBcx+MQ8oXG+ku5/Us+iduv2lqLMlYEjb5eCwZUV
tr7ghd7P7mA7TyVerUG1sL9UpbJWH1oue6FDYg/qdYaWbK6CgrCHRlCqYubUbrZp
S9kib2KkYV0H89iKGtBAq1iX40ytvM+eGGUxcWe/lFF+Pljk2jchgLYV6h5eyq0J
P7BMvAIHE3cWARjR23FgqXx5sMnqV7bxWSDFPAYMQUm7cqRh9SyiQDf5YI1Jl6l8
7n8lOqGnRMULZesyk4d/h5BgW2fIMp5FA0sNLjwrR6HffuTmaHP93PZ/OhZ9m6zl
swx3u+2LG5iL1xdReIL2Lp9+x0EGnP5ywmjmgA7PsDL8OnwBmzvAh9/gG1B8RAhT
T5BizOGHx2Vfr3etr2em
=KX6I
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--
