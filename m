From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Thu, 30 Oct 2014 20:40:16 +0000
Subject: Re: [PATCH 0/6] ARM: shmobile: Change to using clock-indices
Message-Id: <5452A230.30605@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1414592353-24044-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1414592353-24044-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>, Mike Turquette <mturquette@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: devicetree@vger.kernel.org, linux-sh@vger.kernel.org

On 29/10/14 14:19, Geert Uytterhoeven wrote:
> 	Hi Mike, Simon, Magnus,
> 
> This patch series finalizes the conversion from the vendor-specific
> "renesas,clock-indices" to the generic "clock-indices", started by Ben Dooks.
> 
> The patches for r8a7790 and r8a7791 were extracted from a patch that Ben sent
> before ("[PATCH 2/3] renesas: change to using clock-indices"), but it was never
> split/updated.
> 
> Thanks for applying!

Thanks for following this up, i've not had time to look at any of this
code recently.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
