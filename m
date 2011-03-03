From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 03 Mar 2011 13:55:24 +0000
Subject: Re: [PATCH (sh-2.6) 1/4] clksource: Generic timer infrastructure
Message-Id: <201103031455.25089.arnd@arndb.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1298369864-24429-1-git-send-email-peppe.cavallaro@st.com> <201103030945.07486.arnd@arndb.de> <4D6F6C96.1010303@st.com>
In-Reply-To: <4D6F6C96.1010303@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peppe CAVALLARO <peppe.cavallaro@st.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Stuart MENEFY <stuart.menefy@st.com>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, John Stultz <johnstul@us.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>

On Thursday 03 March 2011, Peppe CAVALLARO wrote:
> This logic is already in the driver, indeed.
> What I've seen on our embedded systems is that the
> cost of RX interrupts is very hight and NAPI partially helps.
> Typically, in an IP-STB, I receive a burst of UDP pkt
> and this  means that many interrupts occur (~99% of CPU
> usage on slow platforms).
> With the ext timer I was able to reduce the CPU usage in
> these kind of scenarios to ~50%.

I don't understand. Shouldn't the interrupts be stopped as long
as the system is busy? This sounds like a bug in your NAPI
handling, or maybe you just need to use a lower NAPI_WEIGHT
so you stay in polling mode longer.

	Arnd
