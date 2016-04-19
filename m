From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 19 Apr 2016 10:56:55 +0000
Subject: Re: [PATCH] arch/defconfig: remove CONFIG_RESOURCE_COUNTERS
Message-Id: <4214150.v1WFzl5UmK@wuerfel>
List-Id: <linux-sh.vger.kernel.org>
References: <146105442758.18940.2792564159961963110.stgit@zurg>
In-Reply-To: <146105442758.18940.2792564159961963110.stgit@zurg>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Konstantin Khlebnikov <koct9i@gmail.com>, x86@kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, linux-mips@linux-mips.org, linux-am33-list@redhat.com, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org

On Tuesday 19 April 2016 11:27:07 Konstantin Khlebnikov wrote:
> This option replaced by PAGE_COUNTER which is selected by MEMCG.
> 
> Signed-off-by: Konstantin Khlebnikov <koct9i@gmail.com>
> 
Acked-by: Arnd Bergmann <arnd@arndb.de>
