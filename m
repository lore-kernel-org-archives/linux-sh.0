From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Tue, 20 Oct 2015 12:52:52 +0000
Subject: Re: [PATCH RFC RFT 2/3] clk: clk_put WARNs if user has not disabled clk
Message-Id: <20151020125251.GM32536@n2100.arm.linux.org.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1438974570-20812-1-git-send-email-mturquette@baylibre.com>
 <1438974570-20812-3-git-send-email-mturquette@baylibre.com>
 <CAMuHMdX8Fq3AfxuZMLe4-CYFzrDiQcwnREQhX5fSGXzYNSkKsA@mail.gmail.com>
 <20151020124000.20687.60752@quantum>
In-Reply-To: <20151020124000.20687.60752@quantum>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Oct 20, 2015 at 05:40:00AM -0700, Michael Turquette wrote:
> Why not keep the reference to the struct clk after get'ing it the first
> time?

Yes, that's exactly what you're supposed to do in this case.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
