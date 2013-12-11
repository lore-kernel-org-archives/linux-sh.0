From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Wed, 11 Dec 2013 10:06:54 +0000
Subject: Re: [PATCH] ARM: rcar-gen2: Do not attempt to re-setup timer if running correctly
Message-Id: <52A8393E.2030007@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1386753916-25648-1-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1386753916-25648-1-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 11/12/13 09:25, Ben Dooks wrote:
> If the system has been started in non-secure mode, then the ARM generic
> timer is not configurable during the kernel initialisation. Currently
> the only thing we can check for is if the timer has been correctly
> configured during the boot process.
>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> Reviewed-by: Ian Molton <ian.molton@codethink.co.uk>

Sorry, I've gone and re-posted the same patch as yesterday.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
