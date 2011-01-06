From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Thu, 06 Jan 2011 14:19:46 +0000
Subject: Re: [PATCH 1/2] stackprotector: add stack smashing protector
Message-Id: <20110106141946.GE31708@n2100.arm.linux.org.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1293111851-7175-1-git-send-email-filippo.arcidiacono@st.com>
	<4D245D16.5010702@st.com>
	<20110106093940.GA31708@n2100.arm.linux.org.uk>
	<4D25CEB9.7090205@st.com>
In-Reply-To: <4D25CEB9.7090205@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Jan 06, 2011 at 03:16:25PM +0100, Carmelo AMOROSO wrote:
> Well, SH (in CC) does not have this support. Indeed we posted it
> initially to linux-sh only. We got useful feedback from Paul, Mike and
> Nicolas suggesting to promote the ARM/SH solution based on the global
> __stack_chk_guard variable as a generic solution for all other
> architectures. This is why I thought to post to the LKML instead of each
> linux-<arch> list.

Have you thought about posting it to _the_ linux-arch list?
