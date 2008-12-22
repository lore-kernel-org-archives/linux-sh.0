From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 22 Dec 2008 02:36:34 +0000
Subject: Re: [PATCH] add UIO support for JPU.
Message-Id: <20081222023634.GA4182@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <494EF5CF.1030901@igel.co.jp>
In-Reply-To: <494EF5CF.1030901@igel.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Dec 22, 2008 at 11:05:03AM +0900, Takanari Hayama wrote:
> Add JPU support on Migo-R via UIO. This make use of Magnus's
> generic UIO platform driver. Chunk of contiguous memory to hold
> intermediate image and compressed data during encode and decode.
> 
> Signed-off-by: Takanari Hayama <taki@igel.co.jp>

Applied, thanks.
