From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 05 Sep 2014 16:17:44 +0000
Subject: Re: [GIT PULL] Renesas ARM Based SoC r8a7740 CCF and Timers Updates for v3.18
Message-Id: <201409051817.44447.arnd@arndb.de>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1409030383.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1409030383.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tuesday 26 August 2014, Simon Horman wrote:
> Please consider these Renesas ARM based SoC r8a7740 CCF and timers updates
> for v3.18.
> 
> These changes are in their own branch as there are SoC and board changes
> that depend on DT changes, the reverse of the usual branch dependencies.
> 

Thanks for splitting these out. I decided to put them into next/soc in the
end, since it didn't feel worth doing something special about them

	Arnd
