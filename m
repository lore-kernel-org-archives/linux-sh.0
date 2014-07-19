From: Olof Johansson <olof@lixom.net>
Date: Sat, 19 Jul 2014 18:55:48 +0000
Subject: Re: [GIT PULL] Renesas ARM Based SoC Boards Cleanups Updates for v3.17
Message-Id: <20140719185548.GC4265@quad.lixom.net>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1405641497.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1405641497.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Jul 18, 2014 at 08:59:25AM +0900, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider these Renesas ARM based SoC Boards Cleanups updates for v3.17.
> 
> This pull request is based on a merge of:
> 
> * "Fourth Round of Renesas ARM Based SoC Defconfig Updates for v3.17",
>   tagged as renesas-defconfig4-for-v3.17,
>   which I have sent a pull request for.
> 
>   The reason for this dependency is to avoid attempts to use
>   genmai_defconfig after the board code it relies on has been removed.

I'd prefer not to add this dependency. It's not a big deal to have a defconfig
that won't build momentarily, it doesn't cause any real harm and I'd rather
avoid keeping this merge/dependency. Can you respin this?

> * "Renesas ARM Based SoC DT Timers Updates for v3.17",
>   tagged as renesas-dt-timers-for-v3.17,
>   which I have sent a pull request for.

Hmm. You're doing cleanups on top of new development instead of the other way
around. Try to avoid that in future releases if you can.


-Olof
