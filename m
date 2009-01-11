From: "Edgar E. Iglesias" <edgar.iglesias@axis.com>
Date: Sun, 11 Jan 2009 10:42:59 +0000
Subject: Re: [Qemu-devel] sh: dcache flush breaks text region?
Message-Id: <20090111104259.GE26952@edgar.se.axis.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4968DD28.3030709@juno.dti.ne.jp>
	<20090110195332.GD26952@edgar.se.axis.com>
	<49696E54.9030102@juno.dti.ne.jp>
In-Reply-To: <49696E54.9030102@juno.dti.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Shin-ichiro KAWASAKI <kawasaki@juno.dti.ne.jp>
Cc: qemu-devel@nongnu.org, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

On Sun, Jan 11, 2009 at 12:58:12PM +0900, Shin-ichiro KAWASAKI wrote:
>
> Edgar E. Iglesias wrote:
>> Another solution might be for linux to use a ocpb followed by a ocpi insn
>> on the line. IIUC that should achieve the same results net results.
> I'm not sure about it.  But I think we should not modify linux,

I agree.

The ocpb followed by the ocpi that I suggested won't work and I cant
think of anything better than what linux is already doing.

Best regards
