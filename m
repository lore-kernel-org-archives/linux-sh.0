From: "Francis Moreau" <francis.moro@gmail.com>
Date: Mon, 28 Jan 2008 14:28:40 +0000
Subject: Re: set_dma_addr missing ?
Message-Id: <38b2ab8a0801280628n6e67dca0hcba077b496a795e8@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <38b2ab8a0801261302i68a84fdo6d6ebdb26d9acfc8@mail.gmail.com>
In-Reply-To: <38b2ab8a0801261302i68a84fdo6d6ebdb26d9acfc8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello Stuart,

On Jan 28, 2008 3:00 PM, Stuart MENEFY <stuart.menefy@st.com> wrote:
> I don't think there is much (if any) of it in the kernel.org trees
> at the moment, have a look at the latest source release:
> http://stlinux.com/pub/stlinux/2.3/updates/RPMS/host/stlinux23-host-kernel-source-sh4-2.6.23.13_stm23_0106-106.noarch.rpm
>

Isn't there a git tree (or any other scm tree) somewhere instead of a RPM
package ?

> The FDMA stuff is all in drivers/stm (as in theory it should be shared
> between a couple of architectures, in practice it isn't yet).
>

Are we taking about the DMAC of the ST40 ?

-- 
Francis
