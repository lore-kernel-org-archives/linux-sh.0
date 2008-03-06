From: Hideo Saito <saito@densan.co.jp>
Date: Thu, 06 Mar 2008 05:07:26 +0000
Subject: Re: a problem on copy_user_highpage
Message-Id: <20080306.140726.125129801.saito@densan.co.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <20080306.134927.68563523.saito@densan.co.jp>
In-Reply-To: <20080306.134927.68563523.saito@densan.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Sorry, there is a typo.

> +	kunmap_atomic(vfrom, KM_USER10);
+	kunmap_atomic(vfrom, KM_USER0);
