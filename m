From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Sun, 30 Mar 2014 13:36:34 +0000
Subject: Re: [PATCH] ASoC: rsnd: fix src clock prepare/unprepare
Message-Id: <53381DE2.9050907@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1396018997-12390-1-git-send-email-ben.dooks@codethink.co.uk> <20140329101043.GF21628@sirena.org.uk>
In-Reply-To: <20140329101043.GF21628@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com, lgirdwood@gmail.com, linux-sh@vger.kernel.org, magnus.damm@opensource.se, linux-kernel@lists.codethink.co.uk

On 29/03/14 10:10, Mark Brown wrote:
>>  sound/soc/sh/rcar/scu.c | 4 ++--

It was against your current development branch which is
what we having been testing against (due to the large number
of commits in the rcar area)

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
