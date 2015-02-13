From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Fri, 13 Feb 2015 22:58:54 +0000
Subject: Re: [PATCH v2] ARM: smp: Only expose /sys/.../cpuX/online if hotpluggable
Message-Id: <20150213225854.GG8656@n2100.arm.linux.org.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1423850799-4028-1-git-send-email-sboyd@codeaurora.org>
 <20150213202002.GB29727@verge.net.au>
 <54DE5D3A.5070104@codeaurora.org>
 <CANqRtoSOBf3ZCKdKYta-P2q==ZMHk=VZgfEztPJ+uaKQtkBWjg@mail.gmail.com>
In-Reply-To: <CANqRtoSOBf3ZCKdKYta-P2q==ZMHk=VZgfEztPJ+uaKQtkBWjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Feb 13, 2015 at 08:54:22PM +0000, Magnus Damm wrote:
> Thanks for your efforts. Can you please tell me where that limitation
> is located? I'm quite sure I've brought CPU cores up and down
> including CPU0, but maybe something is missing?

If you don't provide a cpu_disable function, by default only the non-boot
(iow, non-CPU0) CPUs can be hotplugged.

If you provide a cpu_disable function, it can instruct the system that
fewer or more CPUs can be hotplugged, including the boot CPU.  The system
will then restrict you to a minimum of any one CPU online.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
