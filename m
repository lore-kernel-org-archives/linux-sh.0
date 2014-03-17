From: Olof Johansson <olof@lixom.net>
Date: Mon, 17 Mar 2014 07:22:45 +0000
Subject: Re: [GIT PULL] Third Round of Renesas ARM Based SoC DT Updates for v3.15
Message-Id: <20140317071840.GD21917@quad.lixom.net>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1392961872.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1392961872.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Feb 21, 2014 at 03:12:51PM +0900, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider this third round of Renesas ARM based SoC DT updates for v3.15.
> 
> This pull request is based on the previous round of
> such requests, tagged as renesas-dt2-for-v3.15,
> which I have already sent a pull-request for.
> 
> 
> The following changes since commit e02ee513eed4bb780848a5cedbd4b39afb395d3e:
> 
>   ARM: shmobile: koelsch dts: Add QSPI nodes (2014-02-06 20:36:12 +0900)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt3-for-v3.15

Merged.

For new DT contents, please pick a sort order. Most platforms use the actual
unit address as the ordering, and not alphabetical based on node name. If you
sort, new additions are less likely to conflict since they won't just be
appended.

If you pick an order, you'll maybe have to re-sort some of your DTS files. Do
so at the beginning of a release cycle and use that as a base for any new
changes when you do.


-Olof
