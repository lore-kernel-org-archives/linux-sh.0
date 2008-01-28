From: Stuart MENEFY <stuart.menefy@st.com>
Date: Mon, 28 Jan 2008 14:00:55 +0000
Subject: Re: set_dma_addr missing ?
Message-Id: <479DE017.50702@st.com>
List-Id: <linux-sh.vger.kernel.org>
References: <38b2ab8a0801261302i68a84fdo6d6ebdb26d9acfc8@mail.gmail.com>
In-Reply-To: <38b2ab8a0801261302i68a84fdo6d6ebdb26d9acfc8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Francis

Francis Moreau wrote:
> On Jan 28, 2008 11:17 AM, Paul Mundt <lethal@linux-sh.org> wrote:
>> That's the plan, yes. DMABRG will probably need some special handling,
>> but that's pretty isolated. The ST40 DMACs will also prove to be a source
>> of irritation, so it's still going to take some iterations before
>> everything is happily migrated
> 
> Sorry to be blind again but I can't find the current DMAC for the ST40...

I don't think there is much (if any) of it in the kernel.org trees
at the moment, have a look at the latest source release:
http://stlinux.com/pub/stlinux/2.3/updates/RPMS/host/stlinux23-host-kernel-source-sh4-2.6.23.13_stm23_0106-106.noarch.rpm

The FDMA stuff is all in drivers/stm (as in theory it should be shared
between a couple of architectures, in practice it isn't yet).

And yes, I know it is in need of a good clean up, sounds like moving
to the dmaengine API would be a good opportunity!

Stuart



