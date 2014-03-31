From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Mon, 31 Mar 2014 10:05:32 +0000
Subject: Re: [PATCH] ASoC: rsnd: fix src clock prepare/unprepare
Message-Id: <53393DEC.9060400@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1396018997-12390-1-git-send-email-ben.dooks@codethink.co.uk> <20140329101043.GF21628@sirena.org.uk> <53381DE2.9050907@codethink.co.uk> <20140330222433.GJ2269@sirena.org.uk>
In-Reply-To: <20140330222433.GJ2269@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com, lgirdwood@gmail.com, linux-sh@vger.kernel.org, magnus.damm@opensource.se, linux-kernel@lists.codethink.co.uk

On 30/03/14 23:24, Mark Brown wrote:
> On Sun, Mar 30, 2014 at 02:36:34PM +0100, Ben Dooks wrote:
>> On 29/03/14 10:10, Mark Brown wrote:
>>>> sound/soc/sh/rcar/scu.c | 4 ++--
>
>> It was against your current development branch which is
>> what we having been testing against (due to the large number
>> of commits in the rcar area)
>
> It would be easier to tell what you are talking about if you were to
> quote some context from what you are replying to...  I'm guessing this
> is the file that doesn't exist, the above path not present in linux-next
> so I don't know what you mean by my "current development branch".  Are
> you *sure* you're not using Linus' tree?

Why would I be using Linus' tree, it just /does not work/ at all.

I used your sound.git tree to work on due to the number of patches
that where there.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
