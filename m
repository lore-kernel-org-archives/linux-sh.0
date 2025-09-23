Received: from sender4-g3-154.zohomail360.com (sender4-g3-154.zohomail360.com [136.143.188.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B391A23AF
	for <linux-sh@vger.kernel.org>; Wed, 24 Sep 2025 00:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.154
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758674595; cv=pass; b=dUNeA1o0wPnX4oz27/3wcjrTiDxnzT1iryvoYyU80I0h4UR9QhVfRjqneMWEHL8hA9iIj6JSDvEH7SV8lEb9N+y3Ta6999vcSYvoHqI7AZKL+OcaxQ5ZXCyAUPHYqmXMdao142y0M7SXTKZYrEBJz2AZVWLRt2V4rmGEGTlaQOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758674595; c=relaxed/simple;
	bh=AzvB575hLT7d+QWmv5ZyHhLdpZ+lJDDTNnPxK7WE86U=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type; b=J+neUk/04Uvl279RkaSwllYyEeQpwcGcQwF2A6qu/wTVmaK1glxWIXM/kORBXl2CbNl7h8w9y5l+lwpecJUizCLuBfuXHhJQCUnLyT8lastGxxfRP8YZlmEtwlyDg6xH8h2gO5hc0NSuy4D2wVHvUVpqJzydTFxfTWWYtkZs2s0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maguitec.com.mx; spf=pass smtp.mailfrom=bounce-zem.maguitec.com.mx; dkim=pass (1024-bit key) header.d=maguitec.com.mx header.i=@maguitec.com.mx header.b=iE2nJmMr; arc=pass smtp.client-ip=136.143.188.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maguitec.com.mx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce-zem.maguitec.com.mx
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maguitec.com.mx header.i=@maguitec.com.mx header.b="iE2nJmMr"
ARC-Seal: i=1; a=rsa-sha256; t=1758674593; cv=none; 
	d=us.zohomail360.com; s=zohoarc; 
	b=IXZ43Uzalp/qbSVZHiQZfVIElMEZLwgunuW+2h/XL/ZwDr9Q89VwP4iOU4kj9Z7nQMh2OdWIKcT9EusGlOB+ux/T2jDIhiJBjCWkWfbdWyyN15OS0MK19rMsB287M2Gs/t/xN5xGvSvGoarQA1OhxFin2x2FLD7YC40mEabXCa0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=us.zohomail360.com; s=zohoarc; 
	t=1758674593; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:MIME-Version:Message-ID:Reply-To:Reply-To:Subject:Subject:To:To:Message-Id:Cc; 
	bh=AzvB575hLT7d+QWmv5ZyHhLdpZ+lJDDTNnPxK7WE86U=; 
	b=POKUFDuUq9rypJ+isHKiRp4PqG0CyRBE0Zkiq2EbD11Y8S6tLoybbenDj7JToDU1pZIxinHEUcCueAUSNUBCh8Q4m7qZsP21cedRXIkqT4jHhwkr+3L2kCKifNi6wuN+WWm0TVcnoEe0YwyY0abJIWZTJQzdoV/jmW0r2ktzztg=
ARC-Authentication-Results: i=1; mx.us.zohomail360.com;
	dkim=pass  header.i=maguitec.com.mx;
	spf=pass  smtp.mailfrom=investorrelations+9b2f6da0-98d8-11f0-9ce0-52540088df93_vt1@bounce-zem.maguitec.com.mx;
	dmarc=pass header.from=<investorrelations@maguitec.com.mx>
Received: by mx.zohomail.com with SMTPS id 1758671654976622.8864921825074;
	Tue, 23 Sep 2025 16:54:14 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; b=iE2nJmMrLQQhAtPgJtXaoSRVlGhhFa+Yg0UBqziAvnsq9WXB1szM31nQHuq7/dt1o4IFAdkFDJ3FqBTSX50b95AZdrJAYG3jcH7kVaNTua3TgexSDjtom6pXYFZ55cOPFgAlbw9OgxAxKUtymozJc4OTap5o38QcXAlJTksKsGw=; c=relaxed/relaxed; s=15205840; d=maguitec.com.mx; v=1; bh=AzvB575hLT7d+QWmv5ZyHhLdpZ+lJDDTNnPxK7WE86U=; h=date:from:reply-to:to:message-id:subject:mime-version:content-type:content-transfer-encoding:date:from:reply-to:to:message-id:subject;
Date: Tue, 23 Sep 2025 16:54:14 -0700 (PDT)
From: Al Sayyid Sultan <investorrelations@maguitec.com.mx>
Reply-To: investorrelations@alhaitham-investment.ae
To: linux-sh@vger.kernel.org
Message-ID: <2d6f.1aedd99b146bc1ac.m1.9b2f6da0-98d8-11f0-9ce0-52540088df93.19978ffc97a@bounce-zem.maguitec.com.mx>
Subject: Thematic Funds Letter Of Intent
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
content-transfer-encoding-Orig: quoted-printable
content-type-Orig: text/plain;\r\n\tcharset="utf-8"
Original-Envelope-Id: 2d6f.1aedd99b146bc1ac.m1.9b2f6da0-98d8-11f0-9ce0-52540088df93.19978ffc97a
X-JID: 2d6f.1aedd99b146bc1ac.s1.9b2f6da0-98d8-11f0-9ce0-52540088df93.19978ffc97a
TM-MAIL-JID: 2d6f.1aedd99b146bc1ac.m1.9b2f6da0-98d8-11f0-9ce0-52540088df93.19978ffc97a
X-App-Message-ID: 2d6f.1aedd99b146bc1ac.m1.9b2f6da0-98d8-11f0-9ce0-52540088df93.19978ffc97a
X-Report-Abuse: <abuse+2d6f.1aedd99b146bc1ac.m1.9b2f6da0-98d8-11f0-9ce0-52540088df93.19978ffc97a@zeptomail.com>
X-ZohoMailClient: External

To: linux-sh@vger.kernel.org
Date: 24-09-2025
Thematic Funds Letter Of Intent

It's a pleasure to connect with you

Having been referred to your investment by my team, we would be=20
honored to review your available investment projects for onward=20
referral to my principal investors who can allocate capital for=20
the financing of it.

kindly advise at your convenience

Best Regards,

Respectfully,
Al Sayyid Sultan Yarub Al Busaidi
Director
