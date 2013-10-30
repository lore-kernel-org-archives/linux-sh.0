From: Simon Horman <horms@verge.net.au>
Date: Wed, 30 Oct 2013 05:14:16 +0000
Subject: Re: [PATCH 2/2 v4] ARM: shmobile: Lager:add SPI FLASH support on QSPI
Message-Id: <20131030051412.GA1603@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1382408472-20315-3-git-send-email-cm-hiep@jinso.co.jp>
In-Reply-To: <1382408472-20315-3-git-send-email-cm-hiep@jinso.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Oct 22, 2013 at 11:21:12AM +0900, Cao Minh Hiep wrote:
> From: Hiep Cao Minh <cm-hiep@jinso.co.jp>
> 
> This patch enables Spansion S25FL512SAGMFIG11 chip on QSPI,
> Add support for the QSPI interface on Lager.
> 
> Signed-off-by: Hiep Cao Minh <cm-hiep@jinso.co.jp>

Hi,

yesterday I stated that I will queue this patch up.
Toady I would like to qualify that statement.

This patch makes use of the new 'num_chipselect' field of
struct rspi_plat_data. This is not present in v3.12-rc7 but
is present in linux-next. Thus I assume that it will
appear in v3.13-rc1. With this in mind I will queue-up
this patch after rebasing my branches on v3.13-rc1 once
it has been released.
