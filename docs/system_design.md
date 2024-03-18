# Sytem design

## 1. Clarify requirement

### Functionnal requirement

- import goods into warehouse
- export goods from warehouse
- tracking position of goods
- tracking history:
    - import, export on goods_stock
- report

### None-functional requirement

- conisten data
- latency:
    - normal query: < 1s
    - action: < 5s
    - report: < 30

## 2. Back envolop estimate

Daily active user: <100  
RPS (request per second): 20  
Read:Write ~ 5:1  

- report: ~5mb per day for 1 warehouse  
- record import/export: 5byte/record

storage per year:  
    - report: 5mb x 30 x 365 ~ 10GB
    - record: 5byte x 2 x 30 x 365 ~ 10byte x 10^4 ~ 100MB

## 3. API design

- import goods into warehouse: import(api_dev_key, goods_info, position, warehouse, quantity, by_user) return (Ok | Fail)
- export goods into warehouse: import(api_dev_key, goods_info, position, warehouse, quantity, by_user) return (OK | Fail)
- tracking position: getPosition(api_dev_key, good_stock_id, warehouse) return position_info
- tracking history:  getHistory(api_dev_key, good_stock_id)

## 4. Model design

```mermaid
---
title: Inventory
---
erDiagram
    goods_note {
        uuid[pk] goods_note_id
        string[idx] goods_stock_id 
        doule quantity
        string user_id
        string warehouse_id
        string position_id
        enum(import-export-other) type    
    }
    goods_stock {
        uuid[pk] goods_stock_id
        double quantity
        position position
    }
    report {
        int month
        int[fk] stock_id
        int[fk] warehouse_id
        file_path file
    }
    warehouse {
        int warehouse_id
        string title
    }
    position {
        int[pk] position_id
        int warehouse_id
        string position
    }

    goods_stock ||--o{ goods_note: have
    warehouse ||--o{ report: have
    warehouse ||--o{ position: have
    goods_stock }o--|| position: in
    goods_stock }o--|| warehouse: in

```

## 5. Highlevel design

![highlevel design](./highlevel_design.png)


## 6. Detail design