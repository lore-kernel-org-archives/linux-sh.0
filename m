From: Olof Johansson <olof@lixom.net>
Date: Tue, 20 May 2014 05:38:39 +0000
Subject: Re: [GIT PULL] Renesas SoC Clock Cleanups for v3.1
Message-Id: <20140520053839.GM18956@quad.lixom.net>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1399967755.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1399967755.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, May 13, 2014 at 05:03:41PM +0900, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider these Renesas SoC Clock Cleanups for v3.16.
> 
> This pull request is based a merge of the following to provide dependencies
> and avoid conflicts.
> 
> * Renesas ARM Based SoC Board Updates for v3.16,
>   tagged as renesas-boards-for-v3.16, which you have already pulled.
> 
> * Renesas ARM Based SoC Clock Updates for v3.16,
>   tagged as renesas-clock-for-v3.16, which you have already pulled.
> 
> * The cmt-mtu2-tmu-cleanups-for-v3.16 branch of
>   Daniel Lezcano's tree.
> 
>   git://git.linaro.org/people/daniel.lezcano/linux.git clockevents/cmt-mtu2-tmu-cleanups

Daniel, I don't think we were part of a three-way handshake on this. Is
this branch 100% guaranteed to be stable between now and when Linus will
merge it, i.e. it will never be rebased? If so, we can pull in a copy
of it. If not, well, that'll get difficult.


-Olof
