From: Christoph Hellwig <hch@infradead.org>
Date: Mon, 23 Aug 2010 10:57:59 +0000
Subject: Re: [PATCH 0/3] Generalise ARM perf-events backend for oprofile
Message-Id: <20100823105759.GA18638@infradead.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1282560381-7700-1-git-send-email-matt@console-pimps.org>
In-Reply-To: <1282560381-7700-1-git-send-email-matt@console-pimps.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Aug 23, 2010 at 11:46:18AM +0100, Matt Fleming wrote:
> The perf-events backend for OProfile that Will Deacon wrote in
> 8c1fc96f6fd1f361428ba805103af0d0eee65179 ("ARM: 6072/1: oprofile: use
> perf-events framework as backend") is of use to more architectures
> than just ARM. Move the code into drivers/oprofile/ so that SH can use
> it instead of the nearly identical copy of its OProfile code.

Nice, I didn't know such a backend already existed.  Now that you
have made it generic we should aim towards making it the only oprofile
backend and getting rid of all the duplication.

